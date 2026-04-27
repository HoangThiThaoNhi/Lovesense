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
            model: "gemini-1.5-flash-latest",
            systemInstruction: SYSTEM_PROMPT,
            safetySettings: [
                { category: "HARM_CATEGORY_HARASSMENT", threshold: "BLOCK_NONE" },
                { category: "HARM_CATEGORY_HATE_SPEECH", threshold: "BLOCK_NONE" },
                { category: "HARM_CATEGORY_SEXUALLY_EXPLICIT", threshold: "BLOCK_NONE" },
                { category: "HARM_CATEGORY_DANGEROUS_CONTENT", threshold: "BLOCK_NONE" },
            ]
        });

        this.fallbackModel = genAI.getGenerativeModel({
            model: "gemini-1.5-pro-latest",
            systemInstruction: SYSTEM_PROMPT
        });
    }

    async fetchOpenRouter(prompt, messages = [], systemOverride = null) {
        if (!process.env.OPENROUTER_API_KEY) return null;
        try {
            const systemContent = systemOverride || SYSTEM_PROMPT;
            const openRouterMessages = messages.map(m => ({
                role: m.role === 'model' || m.role === 'assistant' ? 'assistant' : 'user',
                content: m.content
            }));

            const response = await fetch("https://openrouter.ai/api/v1/chat/completions", {
                method: "POST",
                headers: {
                    "Authorization": `Bearer ${process.env.OPENROUTER_API_KEY}`,
                    "Content-Type": "application/json"
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

            if (!response.ok) return null;
            const data = await response.json();
            return data.choices?.[0]?.message?.content || null;
        } catch (e) {
            return null;
        }
    }

    async generateResponse(prompt, history = []) {
        const cleanHistory = history.map(msg => ({
            role: msg.role || 'user',
            content: msg.content || ''
        }));

        const formattedHistoryForGemini = cleanHistory.map(msg => ({
            role: msg.role === 'user' ? 'user' : 'model',
            parts: [{ text: msg.content }],
        }));

        try {
            const chat = this.model.startChat({ history: formattedHistoryForGemini });
            const result = await chat.sendMessage(prompt);
            return result.response.text();
        } catch (error) {
            if (process.env.GROQ_API_KEY) {
                try {
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
                            messages: [{ role: "system", content: SYSTEM_PROMPT }, ...groqMessages, { role: "user", content: prompt }],
                            temperature: 0.7
                        })
                    });
                    if (groqResponse.ok) {
                        const data = await groqResponse.json();
                        return data.choices[0].message.content;
                    }
                } catch (e) {}
            }
            return await this.fetchOpenRouter(prompt, cleanHistory);
        }
    }

    async analyzeUserTaste(likedProfiles, nopedProfiles = []) {
        try {
            const likedSummaries = likedProfiles.map(p => 
                `[LIKE] Tuổi: ${p.age}, Cao: ${p.height}cm, Nghề: ${p.occupation}, Mục đích: ${p.purpose || 'không rõ'}, Sở thích: ${Array.isArray(p.interests) ? p.interests.join(', ') : p.interests}, Bio: ${p.bio}`
            ).join('\n');

            const nopedSummaries = nopedProfiles.map(p => 
                `[NOPE] Tuổi: ${p.age}, Cao: ${p.height}cm, Nghề: ${p.occupation}, Mục đích: ${p.purpose || 'không rõ'}, Sở thích: ${Array.isArray(p.interests) ? p.interests.join(', ') : p.interests}, Bio: ${p.bio}`
            ).join('\n');

            const prompt = `
                Bạn là một chuyên gia phân tích tâm lý hẹn hò AI.
                Dưới đây là tập dữ liệu (Dataset) gồm các hồ sơ mà người dùng đã THÍCH (Green Flags) và BỎ QUA (Red Flags).
                
                Danh sách ĐÃ THÍCH (Mẫu người họ hướng tới):
                ${likedSummaries}

                Danh sách BỎ QUA (Mẫu người họ không có cảm tình):
                ${nopedSummaries}

                Nhiệm vụ: Phân tích đối chiếu (Contrast Analysis) giữa tập LIKE và NOPE để tìm ra chính xác "GU" của người dùng.
                Tập trung vào:
                1. Nghề nghiệp và Môi trường sống (Ví dụ: Thích người làm nghệ thuật hay văn phòng? Ghét đặc điểm nào?)
                2. Phong cách sống & Sở thích (Ví dụ: Thích người hướng ngoại thể thao hay hướng nội đọc sách?)
                3. Hình thể & Độ tuổi (Xu hướng chọn tuổi và chiều cao so với tập bỏ qua)

                Trả về định dạng JSON duy nhất, không giải thích thêm:
                {
                  "analysis": "Đoạn văn phân tích chuyên sâu về Gu người yêu của user (kết hợp cả những gì họ thích và những gì họ né tránh).",
                  "learned_tags": ["<từ khóa 1>", "<từ khóa 2>", "<từ khóa 3>"]
                }
            `;

            // Try primary AI (Gemini)
            try {
                const response = await this.generateResponse(prompt);
                const cleanedText = response.replace(/```json/g, '').replace(/```/g, '').trim();
                const jsonMatch = cleanedText.match(/\{[\s\S]*\}/);
                if (jsonMatch) return JSON.parse(jsonMatch[0]);
            } catch (e) {
                console.warn("[AI Taste] Gemini Failed, falling back...");
            }

            // Fallback
            const fallbackResponse = await this.fetchOpenRouter(prompt, [], "Bạn là chuyên gia phân tích dữ liệu hẹn hers. Trả về JSON.");
            if (fallbackResponse) {
                const jsonMatch = fallbackResponse.match(/\{[\s\S]*\}/);
                if (jsonMatch) return JSON.parse(jsonMatch[0]);
            }

            return null;
        } catch (e) {
            console.error('[AI Taste Analysis Error]:', e);
            return null;
        }
    }

    async generateDNAReport(dnaVector) {
        const criteriaFramework = require('../config/anof.json');
        
        const prompt = `
            Dữ liệu DNA (Criteria Scores): ${JSON.stringify(dnaVector)}
            Framework Giải thích: ${JSON.stringify(criteriaFramework)}

            Nhiệm vụ: Hãy viết một báo cáo DNA Soulmate cực kỳ chuyên sâu với 2 phần riêng biệt:

            Phần 1: Giải mã bản thân (Self-Analysis)
            - Dùng đại từ "Bạn". 
            - Phân tích xem với DNA này, BẠN là người như thế nào trong tình yêu.
            - Viết 1 đoạn văn summary mặn mà, sâu sắc.
            - Đưa ra 3-5 điểm nhấn (highlights) về tính cách của BẠN (bắt đầu bằng ✨). Không copy nguyên văn ví dụ dưới đây.

            Phần 2: Chân dung Nửa kia lý tưởng (Ideal Partner)
            - Dùng đại từ "Người ấy" hoặc "Nửa kia".
            - Dựa trên DNA của bạn, hãy mô tả "vibe" của người sẽ bù trừ hoặc cộng hưởng tốt nhất với bạn.

            TRẢ VỀ JSON DUY NHẤT THEO CẤU TRÚC:
            {
              "user_summary": "<Nhập đoạn tóm tắt phân tích về bản thân>",
              "user_highlights": ["✨ <Điểm nổi bật 1>", "✨ <Điểm nổi bật 2>", "✨ <Điểm nổi bật 3>"],
              "ideal_partner_vibe": "<Nhập mô tả về nửa kia lý tưởng>"
            }
        `;

        try {
            const text = await this.generateResponse(prompt);
            const cleanedText = text.replace(/```json/g, '').replace(/```/g, '').trim();
            const jsonMatch = cleanedText.match(/\{[\s\S]*\}/);
            return jsonMatch ? JSON.parse(jsonMatch[0]) : {
                user_summary: "DNA của bạn cho thấy bạn là một người rất đặc biệt!",
                user_highlights: ["✨ Bí ẩn", "✨ Sâu sắc"],
                ideal_partner_vibe: "Một người thấu hiểu và có cùng tần số với bạn."
            };
        } catch (e) {
            return {
                user_summary: "Phân tích DNA của bạn đang được xử lý...",
                user_highlights: ["✨ Đang cập nhật"],
                ideal_partner_vibe: "Đang tìm kiếm người có vibe phù hợp..."
            };
        }
    }

    async generateIdealPartnerProfile(surveyAnswers) {
        const criteriaFramework = require('../config/anof.json');
        const timestamp = new Date().toISOString();

        const prompt = `Bạn là một Quân sư Tình yêu.
        Dữ liệu DNA: ${JSON.stringify(surveyAnswers)}
        Framework: ${JSON.stringify(criteriaFramework)}
        Thời điểm: ${timestamp}
        TRẢ VỀ JSON:
        {
          "analysis_summary": "...",
          "choice_commentary": "...",
          "target_tags": ["tag1", "tag2"],
          "description": "...",
          "preference_vector": [22 số thực]
        }`;

        try {
            const text = await this.generateResponse(prompt);
            const jsonMatch = text.match(/\{[\s\S]*\}/);
            return jsonMatch ? JSON.parse(jsonMatch[0]) : null;
        } catch (e) { return null; }
    }

    async calculateDNAProfile(answers, aiVector = null) {
        let scores = { ambition_score: 50, personality_score: 50, career_score: 50, core_values_score: 50, interests_score: 50, lifestyle_score: 50, family_orientation_score: 50 };
        
        if (aiVector && typeof aiVector === 'object' && !Array.isArray(aiVector)) {
            // Helper to convert [-1.0, 1.0] to [0, 100]
            const mapScore = (val) => {
                if (val === undefined || val === null) return 50;
                return Math.round(((val + 1) / 2) * 100);
            };

            const avg = (keys) => {
                let sum = 0;
                let count = 0;
                keys.forEach(k => {
                    if (aiVector[k] !== undefined) {
                        sum += aiVector[k];
                        count++;
                    }
                });
                return count === 0 ? 50 : mapScore(sum / count);
            };

            scores.ambition_score = avg(['career_ambition', 'intellectual_curiosity']);
            scores.personality_score = avg(['extroversion', 'emotional_stability', 'openness_to_exp']);
            scores.career_score = avg(['career_ambition', 'spending_habit']);
            scores.core_values_score = avg(['religion_influence', 'political_view', 'loyalty_definition']);
            scores.interests_score = avg(['travel_style', 'intellectual_curiosity']);
            scores.lifestyle_score = avg(['cleanliness_level', 'diet_fitness', 'circadian_rhythm', 'spending_habit']);
            scores.family_orientation_score = avg(['family_goal', 'loyalty_definition', 'attachment_style']);
        } else if (aiVector && Array.isArray(aiVector)) {
            scores.ambition_score = Math.round((aiVector[10] || 0.5) * 100);
            scores.personality_score = Math.round(((aiVector[0] || 0.5) + (aiVector[1] || 0.5)) / 2 * 100);
            // Additional basic mappings for the array format
            scores.career_score = Math.round((aiVector[11] || 0.5) * 100);
            scores.core_values_score = Math.round((aiVector[6] || 0.5) * 100);
            scores.interests_score = Math.round((aiVector[17] || 0.5) * 100);
            scores.lifestyle_score = Math.round((aiVector[12] || 0.5) * 100);
            scores.family_orientation_score = Math.round((aiVector[4] || 0.5) * 100);
        }
        
        return scores;
    }
}

module.exports = new AIService();
