const { GoogleGenerativeAI } = require("@google/generative-ai");
const dotenv = require('dotenv');

console.log("🚀 LOVESENSE AI ENGINE V4 - ACTIVATED");

dotenv.config();

const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY);

const SYSTEM_PROMPT = `
# VAI TRÒ:
Bạn là "Lovesense Advisor" - Quân sư tình yêu Gen Z độc quyền của app Lovesense. Nhiệm vụ của bạn là biến người dùng từ "độc thân" thành "có chủ" thông qua sự tinh tế và các tính năng của app.

# CÁ TRÍNH VÀ NGÔN NGỮ:
- Phong cách: Hài hước, mặn mà, bắt trend cực nhanh (flex, red flag, green flag, check var, lụy, đỉnh nóc kịch trần, mỏ hỗn nhưng lịch sự...).
- Xưng hô: "Mình" và "Bạn".
- Thái độ: Luôn đứng về phía người dùng, cổ vũ họ chủ động nhưng phải tinh tế.

# NHIỆM VỤ CHI TIẾT & NGHIỆP VỤ (CORE LOGIC):
1. Tư vấn Matching: Phân tích kết quả từ tính năng "Tar" để chỉ ra điểm chung giữa 2 người (sở thích, vibe, cung hoàng đạo).
2. Sáng tạo "Thính": Gợi ý những câu mở lời (ice-breakers) độc đáo dựa trên profile đối phương. Tránh tuyệt đối các câu sến súa lỗi thời.
3. Tối ưu Profile (UX/UI Nudge): Nếu user thiếu ảnh hoặc bio, hãy nhắc nhở họ hoàn thiện.
4. Gamification (KPI Quan trọng): Luôn nhắc người dùng rằng các hành động (Thêm ảnh, Chat với AI, Hoàn thành hồ sơ) sẽ giúp họ nhận "Điểm thưởng" để đổi Voucher (Highlands, Grab, Shopee...).

# QUY TẮC TRẢ LỜI "THÉP":
- ĐỘ DÀI:  Phải rõ ràng, đi thẳng vào trọng tâm câu hỏi.
- KHÔNG CHÀO HỎI RƯỜM RÀ: Không bắt đầu bằng "Chào bạn", "Tôi có thể giúp gì". Hãy trả lời trực tiếp vấn đề.
- EMOJI: Sử dụng tối đa 4 emoji mỗi lần phản hồi lại cho người dùng (✨, 🔥, 💖, 😎, 🚩) để tăng vibe teen.
- PHẠM VI: Chỉ trả lời về hẹn hò và Lovesense. Nếu hỏi ngoài luồng, hãy lái về chuyện tình cảm hoặc từ chối khéo bằng một câu đùa.
`;

class AIService {
    constructor() {
        this.model = genAI.getGenerativeModel({
            model: "gemini-1.5-flash", // Chuyển về 1.5 Flash để đảm bảo độ ổn định cao nhất cho mọi vùng
            systemInstruction: SYSTEM_PROMPT,
            safetySettings: [
                { category: "HARM_CATEGORY_HARASSMENT", threshold: "BLOCK_NONE" },
                { category: "HARM_CATEGORY_HATE_SPEECH", threshold: "BLOCK_NONE" },
                { category: "HARM_CATEGORY_SEXUALLY_EXPLICIT", threshold: "BLOCK_NONE" },
                { category: "HARM_CATEGORY_DANGEROUS_CONTENT", threshold: "BLOCK_NONE" },
            ]
        });

        // Model dự phòng dùng bản 1.5 pro nếu cần phân tích sâu
        this.fallbackModel = genAI.getGenerativeModel({
            model: "gemini-1.5-pro",
            systemInstruction: SYSTEM_PROMPT
        });
    }

    async fetchOpenRouter(prompt, messages = [], systemOverride = null) {
        if (!process.env.OPENROUTER_API_KEY) return null;
        try {
            console.log("[AI Service] Stage 4: Attempting OpenRouter...");
            const systemContent = systemOverride || SYSTEM_PROMPT;

            // Map roles for OpenRouter (assistant instead of model)
            const openRouterMessages = messages.map(m => ({
                role: m.role === 'model' || m.role === 'assistant' ? 'assistant' : 'user',
                content: m.content
            }));

            const response = await fetch("https://openrouter.ai/api/v1/chat/completions", {
                method: "POST",
                headers: {
                    "Authorization": `Bearer ${process.env.OPENROUTER_API_KEY}`,
                    "Content-Type": "application/json",
                    "HTTP-Referer": "http://localhost:5000",
                    "X-Title": "LoveSense App"
                },
                body: JSON.stringify({
                    model: "google/gemini-2.0-flash-exp:free",
                    messages: [
                        { role: "system", content: systemContent },
                        ...openRouterMessages,
                        { role: "user", content: prompt }
                    ],
                    temperature: 0.7
                })
            });

            if (!response.ok) {
                const errText = await response.text();
                console.error("[AI Service] OpenRouter HTTP Error:", response.status, errText);
                return null;
            }

            const data = await response.json();
            if (data.error) {
                console.error("[AI Service] OpenRouter API Error:", data.error);
                return null;
            }

            return data.choices?.[0]?.message?.content || null;
        } catch (e) {
            console.error("[AI Service] OpenRouter Fetch Error:", e.message);
            return null;
        }
    }

    async generateResponse(prompt, history = []) {
        // Ensure history messages have 'content' and 'role'
        const cleanHistory = history.map(msg => ({
            role: msg.role || 'user',
            content: msg.content || ''
        }));

        const formattedHistoryForGemini = cleanHistory.map(msg => ({
            role: msg.role === 'user' ? 'user' : 'model',
            parts: [{ text: msg.content }],
        }));

        // 1. Stage 1: Gemini Main
        try {
            console.log("[AI Service] Stage 1: Attempting Gemini Main...");
            const chat = this.model.startChat({ history: formattedHistoryForGemini });
            const result = await chat.sendMessage(prompt);
            const response = result.response.text();
            if (response) return response;
        } catch (error) {
            console.warn("⚠️ Stage 1 Failed:", error.message);

            // 2. Stage 2: Groq AI
            if (process.env.GROQ_API_KEY) {
                try {
                    console.log("[AI Service] Stage 2: Attempting Groq AI...");

                    // Map roles for Groq (assistant instead of model)
                    const groqMessages = cleanHistory.map(m => ({
                        role: m.role === 'model' || m.role === 'assistant' ? 'assistant' : 'user',
                        content: m.content
                    }));

                    const groqResponse = await fetch("https://api.groq.com/openai/v1/chat/completions", {
                        method: "POST",
                        headers: {
                            "Authorization": `Bearer ${process.env.GROQ_API_KEY}`,
                            "Content-Type": "application/json"
                        },
                        body: JSON.stringify({
                            model: "llama-3.3-70b-versatile",
                            messages: [
                                { role: "system", content: SYSTEM_PROMPT },
                                ...groqMessages,
                                { role: "user", content: prompt }
                            ],
                            temperature: 0.7
                        })
                    });

                    if (groqResponse.ok) {
                        const groqData = await groqResponse.json();
                        if (groqData.choices?.[0]?.message?.content) {
                            console.log("✅ Stage 2: Groq AI Success!");
                            return groqData.choices[0].message.content;
                        }
                    } else {
                        console.error("[AI Service] Groq API HTTP Error:", groqResponse.status);
                    }
                } catch (groqErr) {
                    console.error("❌ Stage 2: Groq AI Error:", groqErr.message);
                }
            }

            // 3. Stage 3: Gemini Fallback
            try {
                console.log("[AI Service] Stage 3: Attempting Gemini Fallback...");
                const chatFallback = this.fallbackModel.startChat({ history: formattedHistoryForGemini });
                const resultFallback = await chatFallback.sendMessage(prompt);
                const responseFallback = resultFallback.response.text();
                if (responseFallback) return responseFallback;
            } catch (fallbackError) {
                console.warn("⚠️ Stage 3 Failed:", fallbackError.message);

                // 4. Stage 4: OpenRouter
                const fallback = await this.fetchOpenRouter(prompt, cleanHistory);
                if (fallback) {
                    console.log("✅ Stage 4: OpenRouter Success!");
                    return fallback;
                }

                throw new Error("Hệ thống tư vấn đang bận xử lý dữ liệu. Bạn vui lòng thử lại sau giây lát nhé!");
            }
        }
    }

    async parseProfileFromChat(history) {
        const prompt = `Trích xuất thông tin hồ sơ từ chat dưới dạng JSON: ${JSON.stringify(history)}`;
        try {
            const text = await this.generateResponse(prompt);
            const jsonMatch = text.match(/\{[\s\S]*\}/);
            return jsonMatch ? JSON.parse(jsonMatch[0]) : null;
        } catch (e) { return null; }
    }

    async generateIdealPartnerProfile(surveyAnswers) {
        console.log("[AI Service] Analyzing survey answers for uniqueness check:", JSON.stringify(surveyAnswers).substring(0, 200));
        const criteriaFramework = require('../config/anof.json');
        const timestamp = new Date().toISOString();

        const prompt = `Bạn là một Quân sư Tình yêu (Matchmaking Mentor) thân thiện và sâu sắc.
        Dữ liệu DNA người dùng: ${JSON.stringify(surveyAnswers)}
        Framework đánh giá: ${JSON.stringify(criteriaFramework)}
        Thời điểm phân tích (ID duy nhất): ${timestamp}

        NHIỆM VỤ CỦA BẠN:
        1. PHÂN TÍCH NHƯ NGƯỜI THẬT: Dùng ngôn ngữ tự nhiên, gần gũi. Tuyệt đối không dùng thuật ngữ chuyên môn.
        2. TÍNH DUY NHẤT: Đây là một phiên phân tích mới (${timestamp}). Hãy đưa ra những nhận xét độc bản, không lặp lại các khuôn mẫu trước đó.
        3. NHẬN XÉT RÕ RÀNG: Nói thẳng vào bản chất con người họ dựa trên các câu trả lời cụ thể.
        4. HÌNH MẪU NGƯỜI ẤY: Mô tả chân dung người yêu thực tế nhất.

        YÊU CẦU ĐỊNH DẠNG JSON:
        {
          "analysis_summary": "Tiêu đề ấn tượng (Duy nhất cho phiên này)",
          "choice_commentary": "Nhận xét chân thành, sâu sắc, không lặp lại input. (Ít nhất 5 câu)",
          "target_tags": ["Tên_Tính_Cách", "Sở_Thích_Chính", ...],
          "description": "Mô tả chi tiết về người ấy lý tưởng.",
          "preference_vector": [22 số thực]
        }
        
        QUY TẮC TAG: 
        - Phải là các từ đơn hoặc cụm từ cực ngắn có nghĩa (vd: 'Hướng-ngoại', 'Nghệ-thuật', 'Sâu-sắc', 'Du-lịch').
        - KHÔNG được trả về câu văn. 
        - KHÔNG được dùng các từ chung chung như 'Là', 'Và', 'Người'.

        NGÔN NGỮ: Tiếng Việt. CHỈ TRẢ VỀ JSON.`;

        const parseJSON = (text) => {
            try {
                const jsonMatch = text.match(/\{[\s\S]*\}/);
                if (!jsonMatch) return null;
                let jsonStr = jsonMatch[0].replace(/,\s*([\]\}])/g, '$1');
                return JSON.parse(jsonStr);
            } catch (e) { return null; }
        };

        // 1. Try Gemini primary (With creative temperature)
        try {
            console.log("[AI Service] Attempting Deep Analysis with Gemini...");
            const model = genAI.getGenerativeModel({
                model: "gemini-1.5-flash",
                generationConfig: {
                    temperature: 1.0,
                    topP: 0.95,
                },
                systemInstruction: "Bạn là bậc thầy quân sư tình yêu. Trả về JSON duy nhất cho mỗi lần gọi."
            });
            const result = await model.generateContent(prompt);
            const text = result.response.text();
            const parsed = parseJSON(text);
            if (parsed && parsed.analysis_summary) return parsed;
        } catch (e) {
            console.error("❌ [AI Service] Gemini ERROR:", e.message);
            if (e.message.includes("API key not valid")) {
                console.error("👉 Giải pháp: Key Gemini trong .env của bạn bị sai hoặc hết hạn. Hãy lấy key mới tại https://aistudio.google.com/app/apikey");
            }
        }

        // 2. Try Fallback: OpenRouter
        try {
            console.log("[AI Service] Trying fallback to OpenRouter...");
            const fallbackText = await this.fetchOpenRouter(prompt, [], "Bạn là chuyên gia tâm lý. Trả về JSON.");
            if (fallbackText) {
                const parsed = parseJSON(fallbackText);
                if (parsed && parsed.analysis_summary) return parsed;
            }
        } catch (e) {
            console.error("❌ [AI Service] OpenRouter ERROR:", e.message);
        }

        // 3. Dynamic Fallback: Calculate vector based on real answers
        console.warn("⚠️ [AI Service] Using Dynamic Logic Fallback (AI Services down).");
        const findA = (c) => surveyAnswers.find(a => a.category?.toLowerCase().includes(c.toLowerCase()))?.answer || "";

        // Map answers to scores (Basic mapping for fallback)
        const getScore = (ans, keyword, high = 0.9, low = 0.2) =>
            ans.toLowerCase().includes(keyword.toLowerCase()) ? high : (Math.random() * 0.4 + 0.3);

        const g1 = findA('G1');
        const g2 = findA('G2');
        const g3 = findA('G3');
        const g4 = findA('G4');

        // FIX: Preservation of Vietnamese compound words (No more .split(' '))
        const tags = [
            g1.substring(0, 25), // Take meaningful phrases instead of words
            g2.substring(0, 25),
            "Unique"
        ].filter(t => t.length > 2);

        // Create a dynamic vector (22 elements)

        const dynamicVector = Array.from({ length: 22 }, (_, i) => {
            if (i === 0) return getScore(g1, 'Chủ động', 0.9, 0.1);
            if (i === 5) return getScore(g2, 'Tự do', 0.1, 0.8);
            if (i === 10) return getScore(g3, 'Du lịch', 0.9, 0.4);
            return Math.random() * 0.6 + 0.2;
        });

        const randomID = Math.floor(Math.random() * 900) + 100;

        return {
            analysis_summary: `DNA mang sắc thái ${g1.substring(0, 20)}... #${randomID}`,
            choice_commentary: `Dựa trên phân tích mã nguồn #${randomID}, bạn là mẫu người có xu hướng '${g1}'. Bạn tìm kiếm sự kết nối '${g4}' và coi trọng giá trị '${g2}'.`,
            target_tags: tags,
            description: `Người ấy lý tưởng của bạn sẽ mang vibe của một người trân trọng '${g2}' và phù hợp với lối sống '${g3}'.`,
            preference_vector: dynamicVector
        };
    }

    async generateRandomProfiles(count, gender = 'Tất cả', lookingFor = 'Tất cả') {
        const batchSize = 10;
        const batches = Math.ceil(count / batchSize);
        let allProfiles = [];

        for (let b = 0; b < batches; b++) {
            const currentBatchCount = Math.min(batchSize, count - (b * batchSize));
            const prompt = `
# NHIỆM VỤ:
Tạo mảng JSON chứa ${currentBatchCount} hồ sơ người dùng Việt Nam (Gen Z) cực kỳ "vjp pro", mặn mà, đa dạng.
GIỚI TÍNH CỦA NGƯỜI DÙNG: **${gender === 'Tất cả' ? 'Nam hoặc Nữ (ngẫu nhiên)' : gender}**.
ĐỐI TƯỢNG HỌ ĐANG TÌM KIẾM (looking_for): **${lookingFor === 'Tất cả' ? 'Nam hoặc Nữ' : lookingFor}**.

# YÊU CẦU DỮ LIỆU:
- Tên (display_name): Tên thật, trendy (ví dụ: Linh Cute, Hải Bánh, Bảo Bảo, Vy Vy...).
- Tuổi (age): Từ 18 đến 28.
- Bio: Phải hài hước, thả thính, dùng ngôn ngữ Gen Z (flex, lụy, mỏ hỗn lịch sự...).
- Sở thích (interests): Ít nhất 3-5 sở thích thực tế (Boardgame, Netflix, Chạy bộ, Tarot, Phượt...).
- Nghề nghiệp (job): Freelancer, Sinh viên, Designer, KOC, TikToker...

# ĐỊNH DẠNG JSON MẪU:
[
  {
    "display_name": "...",
    "age": 22,
    "gender": "...",
    "looking_for": "...",
    "location": "Ha Noi",
    "job": "...",
    "height": 165,
    "bio": "...",
    "interests": ["...", "..."],
    "purpose": "Hẹn hò/Kết bạn"
  }
]

# QUY TẮC NGHIÊM NGẶT:
- CHỈ TRẢ VỀ MẢNG JSON, KHÔNG GIẢI THÍCH.
- Tuyệt đối không để trống bất kỳ trường nào.
`;

            try {
                const text = await this.generateResponse(prompt);
                // Robust JSON extraction: Strip markdown code blocks and extra text
                let cleanText = text.replace(/```json/g, '').replace(/```/g, '').trim();
                const jsonMatch = cleanText.match(/\[[\s\S]*\]/);

                if (jsonMatch) {
                    try {
                        const profiles = JSON.parse(jsonMatch[0]);
                        if (Array.isArray(profiles)) {
                            allProfiles = allProfiles.concat(profiles);
                        }
                    } catch (parseError) {
                        console.error(`[AI Service] JSON Parse Error in batch ${b}:`, parseError.message);
                        console.log("[AI Service] Raw text that failed to parse:", jsonMatch[0]);
                    }
                } else {
                    console.warn(`[AI Service] No JSON array found in AI response for batch ${b}`);
                    console.log("[AI Service] AI Response:", text);
                }
            } catch (error) {
                console.error(`[AI Service] Error in batch ${b}:`, error.message);
            }
        }
        return allProfiles;
    }
    async analyzeUserDNA(answers, preferences) {
        const criteriaFramework = require('../config/anof.json');
        const timestamp = new Date().toISOString();

        const systemPrompt = `Bạn là một Senior Psychologist và Matchmaking Architect. 
        Nhiệm vụ của bạn là phân tích sâu sắc "DNA tâm lý" của người dùng dựa trên Framework: ${JSON.stringify(criteriaFramework)}.

        Dữ liệu đầu vào:
        1. Câu trả lời thực tế (Bản thân): ${JSON.stringify(answers)}
        2. Mong muốn về đối phương (Lý tưởng): ${JSON.stringify(preferences)}
        3. Thời điểm phân tích: ${timestamp}

        YÊU CẦU PHÂN TÍCH:
        - So sánh sự mâu thuẫn hoặc tương đồng giữa cách người dùng sống (Thực tế) và cách họ muốn người khác sống (Mong muốn).
        - Đánh giá các "Dealbreakers" (is_critical: true) trong nhóm G2, G5.
        - Tạo ra một 'preference_vector' (mảng số thực từ 0.0 - 1.0) đại diện cho 22 tiêu chí trong Framework theo đúng thứ tự xuất hiện.
        - KHÔNG ĐƯỢC lặp lại các câu văn sáo rỗng. Hãy viết những nhận xét mang tính cá nhân hóa cao dựa trên các từ khóa trong câu trả lời.

        BẠN PHẢI TRẢ VỀ ĐÚNG ĐỊNH DẠNG JSON SAU:
        {
          "self_analysis": {
            "summary": "...",
            "strengths": ["..."],
            "growth_areas": ["..."]
          },
          "ideal_partner_profile": {
            "description": "...",
            "key_traits": ["..."],
            "compatibility_advice": "..."
          },
          "preference_vector": [0.1, 0.5, 0.9, ...],
          "top_match_categories": ["G1", "G4"]
        }
        
        Lưu ý: preference_vector phải có chính xác 22 phần tử tương ứng với các criteria trong anof.json.
        CHỈ TRẢ VỀ JSON, KHÔNG KÈM VĂN BẢN KHÁC.`;

        try {
            console.log("[AI Service] Analyzing User DNA...");
            const model = genAI.getGenerativeModel({ model: "gemini-1.5-flash" });
            const result = await model.generateContent(systemPrompt);
            const text = result.response.text();

            // Re-use our robust parseJSON helper
            const jsonMatch = text.match(/\{[\s\S]*\}/);
            if (jsonMatch) {
                return JSON.parse(jsonMatch[0]);
            }
            throw new Error("Failed to parse AI DNA Analysis");
        } catch (error) {
            console.error("[AI Service] DNA Analysis Error:", error);
        }
    }

    async getMatchRecommendations(userProfile, candidates) {
        try {
            const prompt = `
            Dựa trên hồ sơ người dùng: ${JSON.stringify(userProfile)}
            Hãy chọn ra danh sách tối đa 5 người phù hợp nhất từ danh sách sau:
            ${JSON.stringify(candidates)}
            
            Chỉ trả về mảng JSON chứa các ID của những người được chọn. 
            Ví dụ: [1, 5, 12]
            CHỈ TRẢ VỀ JSON.
            `;

            const text = await this.generateResponse(prompt, []);
            const jsonMatch = text.match(/\[.*\]/);
            if (jsonMatch) {
                return JSON.parse(jsonMatch[0]);
            }
            return [];
        } catch (e) {
            console.error("[AI Service] Recommendation Error:", e);
            return [];
        }
    }

    /**
     * CMS Tool: Suggest DNA mappings for a quiz question and its options
     */
    async suggestQuizLogic(question, options, categoryId) {
        const criteriaFramework = require('../config/anof.json');
        const prompt = `
        Bạn là Matchmaking Logic Architect cho app LoveSense. 
        Framework DNA: ${JSON.stringify(criteriaFramework)}
        
        PHÂN TÍCH CÂU HỎI: "${question}"
        CHUYÊN MỤC: ${categoryId}
        ĐÁP ÁN: ${JSON.stringify(options)}

        YÊU CẦU:
        1. Với mỗi đáp án, gợi ý các mappings (criteria_id từ Framework và score_delta từ -1.0 đến 1.0).
        2. Gợi ý meta_hint ngắn gọn.
        
        TRẢ VỀ JSON (CHỈ JSON):
        [
          {
            "label": "Đáp án 1",
            "mappings": [{ "criteria_id": "extroversion", "score_delta": 0.5 }],
            "meta_hint": "..."
          }
        ]`;

        try {
            const text = await this.generateResponse(prompt);
            const jsonMatch = text.match(/\[[\s\S]*\]/);
            return jsonMatch ? JSON.parse(jsonMatch[0]) : [];
        } catch (e) {
            console.error("[AI Service] Suggest Quiz Logic Error:", e);
            return [];
        }
    }

    /**
     * APP Tool: Generate a deep analysis report based on user's DNA Vector
     */
    async generateDNAReport(dnaVector) {
        const criteriaFramework = require('../config/anof.json');

        // 1. Phẳng hóa toàn bộ tiêu chí
        const allCriteria = [];
        criteriaFramework.criteria_framework.forEach(group => {
            group.criteria.forEach(c => {
                allCriteria.push({ ...c, group_name: group.group_name });
            });
        });

        // 2. Chắt lọc những đặc điểm nổi bật nhất để AI không bị "loãng"
        const sortedEntries = Object.entries(dnaVector)
            .filter(([, score]) => Math.abs(score) > 0.1) // Chỉ lấy những gì có ý nghĩa
            .sort(([, a], [, b]) => Math.abs(b) - Math.abs(a));

        const dataForAI = sortedEntries.map(([id, score]) => {
            const c = allCriteria.find(item => item.id === id);

            // Phân loại đa tầng chính xác và tinh tế hơn
            let mucDo = "Trung bình";
            if (score > 0.75) mucDo = "Rất cao";
            else if (score > 0.4) mucDo = "Cao";
            else if (score > 0.15) mucDo = "Trung bình - Khá";
            else if (score < -0.75) mucDo = "Rất thấp";
            else if (score < -0.4) mucDo = "Thấp";
            else if (score < -0.15) mucDo = "Dưới trung bình";

            return `- ${c ? c.name : id} (Mức độ: ${mucDo}, Điểm: ${score.toFixed(2)})`;
        }).join('\n');

        console.log("🧬 [AI Engine] Analyzing User DNA Context:\n", dataForAI);

        const prompt = `
        Bạn là "Lovesense AI Advisor". Nhiệm vụ của bạn là phân tích bản đồ tâm lý người dùng.
        
        DỮ LIỆU DNA THỰC TẾ CỦA NGƯỜI DÙNG:
        ${dataForAI}

        YÊU CẦU PHÂN TÍCH CHUẨN XÁC:
        1. SUMMARY: Viết bài nhận xét (150-200 chữ) cá nhân hóa cực cao. 
           - KHÔNG dùng các câu sáo rỗng. 
           - Dựa vào các chỉ số trên để phác họa tính cách (VD: Nếu 'Hướng ngoại' thấp nhưng 'Tham vọng' cao, hãy gọi họ là "Người kiến tạo thầm lặng").
           - Ngôn ngữ: Gen Z, mặn mà, tinh tế.
        2. HIGHLIGHTS: Trích xuất 3 "Green Flags" thực sự ấn tượng nhất từ dữ liệu.
        3. IDEAL_VIBE: Mô tả người yêu lý tưởng có "tần số" bù đắp hoặc tương đồng hoàn hảo với dữ liệu trên.

        ĐỊNH DẠNG TRẢ VỀ (JSON BẮT BUỘC):
        {
          "summary": "...",
          "highlights": ["...", "...", "..."],
          "ideal_vibe": "..."
        }
        
        QUY TẮC: CHỈ TRẢ VỀ JSON. KHÔNG XIN CHÀO. KHÔNG CẢM ƠN.`;

        // 3. CHIẾN THUẬT GỌI AI ĐA TẦNG (MULTI-STAGE)
        // Lần 1: Thử với Gemini Flash
        try {
            const response = await this.generateResponse(prompt);
            const jsonMatch = response.match(/\{[\s\S]*\}/);
            if (jsonMatch) return JSON.parse(jsonMatch[0].replace(/,\s*([\]\}])/g, '$1'));
        } catch (e) {
            console.error("❌ [Gemini Error]:", e.message);
            console.warn("⚠️ Stage 1 AI Failed, Retrying Stage 2...");
        }

        // Lần 2: Thử với OpenRouter
        try {
            const fallbackResponse = await this.fetchOpenRouter(prompt);
            if (fallbackResponse) {
                const jsonMatch = fallbackResponse.match(/\{[\s\S]*\}/);
                if (jsonMatch) return JSON.parse(jsonMatch[0].replace(/,\s*([\]\}])/g, '$1'));
            }
        } catch (e) {
            console.error("❌ [OpenRouter Error]:", e.message);
        }

        // 4. BIỆN PHÁP CUỐI CÙNG: LOCAL INTELLIGENT ENGINE (Tự lắp ghép bài viết chuẩn 100%)
        console.warn("🚀 [Local Engine] Generating algorithmic report due to API failures...");

        const interpreter = {
            'extroversion': (s) => s > 0.5 ? "Bậc thầy kết nối" : "Người quan sát tinh tế",
            'spending_habit': (s) => s > 0.5 ? "Đại sứ trải nghiệm" : "Tay hòm chìa khóa",
            'career_ambition': (s) => s > 0.5 ? "Chiến thần thăng tiến" : "Người giữ lửa cân bằng",
            'physical_touch_need': (s) => s > 0.5 ? "Ngôn ngữ cơ thể" : "Kết nối tâm hồn",
            'romance_style': (s) => s > 0.5 ? "Phong cách Sến súa" : "Phong cách Thực tế",
            'family_goal': (s) => s > 0.5 ? "Định hướng gia đình" : "Tự do cá nhân"
        };

        const highlights = sortedEntries.slice(0, 3).map(([id, s]) => {
            if (interpreter[id]) return `✨ ${interpreter[id](s)}`;
            return `✨ ${allCriteria.find(c => c.id === id)?.name || id}`;
        });

        // Lấy thông tin từ các chỉ số trong Log của bạn (với giá trị làm tròn)
        const getScore = (key) => parseFloat((dnaVector[key] || 0).toFixed(2));

        const isExtrovert = getScore('extroversion') > 0.1;
        const isSaver = getScore('spending_habit') < -0.1;
        const isPractical = getScore('romance_style') < -0.1;

        const summary = `Dựa trên bản đồ DNA, bạn là một ${isExtrovert ? 'người hướng ngoại tràn đầy năng lượng' : 'người hướng nội sâu sắc'}. ` +
            `Trong cuộc sống, bạn là một '${isSaver ? 'Tay hòm chìa khóa' : 'Đại sứ trải nghiệm'}' thực thụ. ` +
            `Phong cách yêu của bạn thiên về sự ${isPractical ? 'Thực tế và chân thành' : 'Lãng mạn và ngọt ngào'}. ` +
            `Hệ thống đánh giá bạn là một Soulmate cực phẩm, luôn biết cách cân bằng giữa cái tôi cá nhân và hạnh phúc chung.`;

        return {
            summary: summary,
            highlights: highlights,
            ideal_vibe: `Một người trân trọng sự '${highlights[0].replace('✨ ', '')}' và sẵn sàng cùng bạn xây dựng tương lai.`
        };
    }
}

module.exports = new AIService();
