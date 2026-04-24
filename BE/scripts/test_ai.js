require('dotenv').config();
const { GoogleGenerativeAI } = require("@google/generative-ai");

async function testGemini() {
    console.log("🔍 Đang kiểm tra Gemini API Key:", process.env.GEMINI_API_KEY ? "Đã tìm thấy" : "TRỐNG!");
    
    try {
        const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY);
        const model = genAI.getGenerativeModel({ model: "gemini-2.0-flash" });

        console.log("📡 Đang gửi yêu cầu thử nghiệm tới Google...");
        const result = await model.generateContent("Chào bạn, hãy trả lời 'OK' nếu bạn hoạt động tốt.");
        const response = await result.response;
        console.log("✅ KẾT QUẢ: Gemini hoạt động hoàn hảo! Phản hồi:", response.text());
    } catch (error) {
        console.error("❌ LỖI GEMINI:");
        console.error("- Message:", error.message);
        if (error.status) console.error("- Status Code:", error.status);
        if (error.response) {
            console.error("- Chi tiết lỗi từ Google:", JSON.stringify(error.response, null, 2));
        }
        
        if (error.message.includes("API_KEY_INVALID")) {
            console.log("\n👉 HƯỚNG DẪN: API Key của bạn không đúng hoặc đã bị xóa. Hãy tạo key mới tại: https://aistudio.google.com/app/apikey");
        } else if (error.message.includes("User location is not supported")) {
            console.log("\n👉 HƯỚNG DẪN: Vùng địa lý của bạn chưa được hỗ trợ trực tiếp. Hãy thử dùng VPN hoặc chuyển sang dùng OpenRouter.");
        }
    }
}

testGemini();
