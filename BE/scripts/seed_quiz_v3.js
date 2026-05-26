const { QuizQuestion, QuizOption } = require('../src/models');
const sequelize = require('../src/config/db');

const questions = [
    // === SET 1 ===
    {
        set_id: 1,
        text: "Khi đứng trước một đám đông hoàn toàn xa lạ, bạn thường:",
        category: "G1_PERSONALITY",
        sub_category: "extroversion",
        options: ["Chủ động làm quen và dẫn dắt câu chuyện", "Quan sát và chỉ nói khi có người hỏi", "Cảm thấy không thoải mái và muốn rời đi sớm"],
        weight: 4
    },
    {
        set_id: 1,
        text: "Khi gặp stress nặng, bạn thường phản ứng như thế nào?",
        category: "G1_PERSONALITY",
        sub_category: "emotional_stability",
        options: ["Bình tĩnh tìm nguyên nhân và giải quyết", "Dễ cáu gắt và mất kiểm soát cảm xúc", "Cần thời gian ở một mình để cân bằng lại"],
        weight: 5
    },
    {
        set_id: 1,
        text: "Quan điểm của bạn về việc lập gia đình và có con?",
        category: "G2_CORE_VALUES",
        sub_category: "family_goal",
        options: ["Là mục tiêu quan trọng nhất cuộc đời", "Chưa sẵn sàng, muốn tự do trải nghiệm", "Có cũng được, không có cũng không sao"],
        weight: 5
    },
    {
        set_id: 1,
        text: "Theo bạn, hành động nào được coi là phản bội nặng nề nhất?",
        category: "G2_CORE_VALUES",
        sub_category: "loyalty_definition",
        options: ["Ngoại tình thể xác", "Ngoại tình tư tưởng (nhắn tin, thả thính)", "Nói dối về những vấn đề tài chính quan trọng"],
        weight: 5
    },
    {
        set_id: 1,
        text: "Nếu trúng số 1 tỷ đồng, bạn sẽ ưu tiên việc gì đầu tiên?",
        category: "G3_FINANCIAL_LIFESTYLE",
        sub_category: "spending_habit",
        options: ["Gửi tiết kiệm hoặc đầu tư sinh lời", "Mua sắm những thứ mình thích từ lâu", "Dùng để đi du lịch và trải nghiệm"],
        weight: 4
    },
    {
        set_id: 1,
        text: "Bạn cảm thấy được yêu thương nhất khi đối phương thực hiện điều gì?",
        category: "G4_INTIMACY_ROMANCE",
        sub_category: "love_language",
        options: ["Dành thời gian chất lượng bên nhau", "Trao lời khen ngợi và động viên", "Những cử chỉ thân mật (nắm tay, ôm hôn)"],
        weight: 5
    },
    {
        set_id: 1,
        text: "Khi có mâu thuẫn xảy ra, phong cách giải quyết của bạn là:",
        category: "G6_CONFLICT_RESOLUTION",
        sub_category: "communication_style",
        options: ["Nói chuyện thẳng thắn ngay lập tức", "Im lặng để cả hai cùng bình tĩnh lại", "Viết thư hoặc nhắn tin để bày tỏ cảm xúc"],
        weight: 4
    },

    // === SET 2 ===
    {
        set_id: 2,
        text: "Trong một buổi tiệc sinh nhật đông người, bạn có xu hướng:",
        category: "G1_PERSONALITY",
        sub_category: "extroversion",
        options: ["Tìm một góc yên tĩnh nói chuyện với 1-2 người bạn thân", "Chủ động đi chúc rượu và giao lưu với mọi nhóm", "Cảm thấy cạn kiệt năng lượng và muốn về nhà sớm"],
        weight: 4
    },
    {
        set_id: 2,
        text: "Khi mọi việc không diễn ra đúng kế hoạch và xảy ra sự cố đột ngột, bạn thường:",
        category: "G1_PERSONALITY",
        sub_category: "emotional_stability",
        options: ["Mất bình tĩnh và cần người khác xoa dịu cảm xúc", "Nhanh chóng thích ứng và tìm phương án thay thế", "Cảm thấy bế tắc và để mặc mọi chuyện tự giải quyết"],
        weight: 5
    },
    {
        set_id: 2,
        text: "Hình mẫu gia đình lý tưởng trong tương lai của bạn là:",
        category: "G2_CORE_VALUES",
        sub_category: "family_goal",
        options: ["Gia đình truyền thống ấm cúng, có cả con cái và nuôi thú cưng", "Gia đình hiện đại chỉ có hai người tự do trải nghiệm cuộc sống", "Tập trung sự nghiệp trước, kết hôn và con cái tính sau"],
        weight: 5
    },
    {
        set_id: 2,
        text: "Hành vi nào dưới đây khiến bạn khó lòng tha thứ nhất trong tình yêu?",
        category: "G2_CORE_VALUES",
        sub_category: "loyalty_definition",
        options: ["Đối phương vẫn giữ liên lạc mật thiết và tâm sự với người yêu cũ", "Nói dối về các mối quan hệ xã hội hoặc tài chính cá nhân", "Say xỉn và có những cử chỉ quá giới hạn với người khác giới"],
        weight: 5
    },
    {
        set_id: 2,
        text: "Cách bạn phân bổ thu nhập hàng tháng thường là:",
        category: "G3_FINANCIAL_LIFESTYLE",
        sub_category: "spending_habit",
        options: ["Trích ngay 50-70% để tích lũy dài hạn rồi mới chi tiêu", "Chi tiêu thoải mái cho bản thân và gia đình trước, còn lại mới tiết kiệm", "Mua sắm theo cảm hứng và thường xuyên rơi vào cảnh cháy túi"],
        weight: 4
    },
    {
        set_id: 2,
        text: "Hành động lãng mạn nào từ nửa kia khiến trái tim bạn rung động nhất?",
        category: "G4_INTIMACY_ROMANCE",
        sub_category: "love_language",
        options: ["Nhận được một món quà bất ngờ chuẩn bị theo đúng sở thích của bạn", "Đối phương tự tay chuẩn bị bữa tối hoặc làm việc nhà giúp bạn", "Cùng nhau đi dạo dưới mưa và có những cái ôm thật chặt"],
        weight: 5
    },
    {
        set_id: 2,
        text: "Khi hai người bất đồng ý kiến về một quyết định quan trọng, bạn chọn:",
        category: "G6_CONFLICT_RESOLUTION",
        sub_category: "communication_style",
        options: ["Tranh luận quyết liệt đến cùng để tìm ra người đúng", "Chủ động nhường nhịn tạm thời để tránh xung đột leo thang", "Cùng ngồi lại phân tích khách quan lợi ích và hạn chế của từng phương án"],
        weight: 4
    },

    // === SET 3 ===
    {
        set_id: 3,
        text: "Khi rảnh rỗi vào cuối tuần, hoạt động yêu thích của bạn là:",
        category: "G1_PERSONALITY",
        sub_category: "extroversion",
        options: ["Rủ nhóm bạn thân đi cà phê hoặc tham gia các sự kiện sôi động", "Ở nhà đọc sách, xem phim hoặc chơi game một mình", "Đi dạo công viên hoặc tự học thêm một kỹ năng mới"],
        weight: 4
    },
    {
        set_id: 3,
        text: "Khi nhận được những lời chỉ trích hoặc phê bình gay gắt từ người khác, bạn phản ứng:",
        category: "G1_PERSONALITY",
        sub_category: "emotional_stability",
        options: ["Cảm thấy tổn thương sâu sắc và suy nghĩ tiêu cực nhiều ngày", "Lắng nghe chọn lọc, sửa đổi nếu đúng và bỏ qua nếu vô lý", "Lập tức phản kháng và tranh cãi để bảo vệ cái tôi"],
        weight: 5
    },
    {
        set_id: 3,
        text: "Suy nghĩ của bạn về việc sống chung với bố mẹ sau khi kết hôn?",
        category: "G2_CORE_VALUES",
        sub_category: "family_goal",
        options: ["Hoàn toàn đồng ý, thích không khí gia đình nhiều thế hệ", "Muốn ra ở riêng hoàn toàn để đảm bảo sự riêng tư", "Chấp nhận ở chung trong thời gian đầu nghiêm túc tích lũy tài chính"],
        weight: 5
    },
    {
        set_id: 3,
        text: "Theo bạn, nền tảng cốt lõi nhất để duy trì sự chung thủy là gì?",
        category: "G2_CORE_VALUES",
        sub_category: "loyalty_definition",
        options: ["Sự tự giác và tôn trọng ranh giới của bản thân", "Chia sẻ mọi mật khẩu mạng xã hội và định vị cho nhau", "Sự ràng buộc về mặt pháp lý và gia đình hai bên"],
        weight: 5
    },
    {
        set_id: 3,
        text: "Quan điểm của bạn về việc đầu tư tài chính mạo hiểm (chứng khoán, tiền số)?",
        category: "G3_FINANCIAL_LIFESTYLE",
        sub_category: "spending_habit",
        options: ["Hoàn toàn tránh xa, chỉ chọn gửi tiết kiệm ngân hàng an toàn", "Dành một phần nhỏ tài sản để thử sức kiếm lời", "Sẵn sàng đầu tư lớn để có cơ hội đột phá tài chính"],
        weight: 4
    },
    {
        set_id: 3,
        text: "Bạn thích được đối phương bày tỏ tình cảm bằng cách nào nhất?",
        category: "G4_INTIMACY_ROMANCE",
        sub_category: "love_language",
        options: ["Luôn lắng nghe và dành cho bạn những lời khuyên chân thành khi bạn gặp khó khăn", "Những món quà handmade chứa đựng nhiều tâm huyết và kỷ niệm", "Cùng nhau nấu ăn và chia sẻ mọi câu chuyện nhỏ nhặt trong ngày"],
        weight: 5
    },
    {
        set_id: 3,
        text: "Nếu đối phương chiến tranh lạnh (im lặng không nói lý do), bạn thường:",
        category: "G6_CONFLICT_RESOLUTION",
        sub_category: "communication_style",
        options: ["Chủ động hỏi han dồn dập để tìm hiểu nguyên nhân bằng được", "Cũng im lặng theo để xem ai kiên nhẫn hơn", "Nhắc nhở nhẹ nhàng và kiên nhẫn chờ họ sẵn sàng chia sẻ"],
        weight: 4
    },

    // === SET 4 ===
    {
        set_id: 4,
        text: "Tại nơi làm việc hoặc học tập, bạn thường đóng vai trò:",
        category: "G1_PERSONALITY",
        sub_category: "extroversion",
        options: ["Người kết nối sôi nổi, gắn kết tập thể bằng các trò đùa", "Người trầm lặng, tập trung làm tốt phần việc của mình", "Người dẫn dắt và điều phối công việc chung"],
        weight: 4
    },
    {
        set_id: 4,
        text: "Trước một kỳ thi hoặc sự kiện thuyết trình quan trọng, bạn thường cảm thấy:",
        category: "G1_PERSONALITY",
        sub_category: "emotional_stability",
        options: ["Hồi hộp tột độ, mất ngủ và lo lắng tột cùng", "Lo lắng nhẹ nhưng nhanh chóng lấy lại sự tập trung", "Hoàn toàn bình tĩnh và tự tin vào sự chuẩn bị của mình"],
        weight: 5
    },
    {
        set_id: 4,
        text: "Nếu công việc đòi hỏi bạn phải chuyển công tác xa gia đình dài hạn, bạn sẽ:",
        category: "G2_CORE_VALUES",
        sub_category: "family_goal",
        options: ["Từ chối ngay lập tức để ưu tiên ở gần gia đình", "Sẵn sàng đi nếu đối phương đồng ý đồng hành cùng bạn", "Đi một mình để phát triển sự nghiệp trước, chấp nhận yêu xa"],
        weight: 5
    },
    {
        set_id: 4,
        text: "Bạn phản ứng thế nào nếu phát hiện đối phương nói dối bạn về một khoản nợ lớn?",
        category: "G2_CORE_VALUES",
        sub_category: "loyalty_definition",
        options: ["Lập tức chia tay vì sự thiếu trung thực và lòng tin đổ vỡ", "Cùng nhau tìm cách giải quyết nhưng lòng tin bị giảm sút", "Tha thứ hoàn toàn và không truy cứu chuyện đã qua"],
        weight: 5
    },
    {
        set_id: 4,
        text: "Khi lựa chọn một chuyến du lịch, tiêu chí hàng đầu của bạn là:",
        category: "G3_FINANCIAL_LIFESTYLE",
        sub_category: "spending_habit",
        options: ["Tiết kiệm tối đa chi phí đi lại và lưu trú", "Trải nghiệm dịch vụ đẳng cấp, tiện nghi tốt nhất", "Chi tiêu hợp lý dựa trên ngân sách đã lập từ trước"],
        weight: 4
    },
    {
        set_id: 4,
        text: "Khi ở bên cạnh người yêu, bạn thích làm gì nhất?",
        category: "G4_INTIMACY_ROMANCE",
        sub_category: "love_language",
        options: ["Tựa đầu vào vai nhau xem phim hoặc nghe nhạc yên tĩnh", "Cùng nhau tranh luận về các chủ đề xã hội hoặc triết học sâu sắc", "Nắm tay nhau đi dạo phố xá đông đúc"],
        weight: 5
    },
    {
        set_id: 4,
        text: "Khi tranh cãi lên đến điểm đỉnh, hành động khôn ngoan nhất theo bạn là:",
        category: "G6_CONFLICT_RESOLUTION",
        sub_category: "communication_style",
        options: ["Dừng cuộc nói chuyện lại ngay lập tức và đi ra ngoài giải tỏa", "Cố gắng giải thích cặn kẽ để đối phương hiểu mình đúng", "Im lặng lắng nghe đối phương xả giận rồi mới phản hồi"],
        weight: 4
    },

    // === SET 5 ===
    {
        set_id: 5,
        text: "Khi tham gia một câu lạc bộ hoặc lớp học kỹ năng mới, bạn thường:",
        category: "G1_PERSONALITY",
        sub_category: "extroversion",
        options: ["Chủ động làm quen với tất cả mọi người ngay buổi đầu tiên", "Chỉ giao tiếp xã giao khi cần thảo luận nhóm", "Tự làm việc một mình và ít tương tác với xung quanh"],
        weight: 4
    },
    {
        set_id: 5,
        text: "Khi đối mặt với việc chia tay hoặc mất mát tình cảm, bạn thường:",
        category: "G1_PERSONALITY",
        sub_category: "emotional_stability",
        options: ["Ủ rũ suy sụp nhiều tháng liền, khó tập trung vào cuộc sống", "Chấp nhận sự thật, tự chữa lành và phục hồi sau thời gian ngắn", "Lao đầu vào công việc hoặc các hoạt động khác để quên đi nỗi buồn"],
        weight: 5
    },
    {
        set_id: 5,
        text: "Quan điểm của bạn về việc phân chia công việc nhà giữa hai vợ chồng?",
        category: "G2_CORE_VALUES",
        sub_category: "family_goal",
        options: ["Chia đôi công bằng mọi việc dựa trên thời gian rảnh", "Người kiếm tiền nhiều hơn sẽ làm ít việc nhà hơn", "Linh hoạt hỗ trợ nhau không câu nệ phân chia chi tiết"],
        weight: 5
    },
    {
        set_id: 5,
        text: "Theo bạn, việc kết bạn và đi chơi riêng với người khác giới khi đã có người yêu là:",
        category: "G2_CORE_VALUES",
        sub_category: "loyalty_definition",
        options: ["Hoàn toàn bình thường miễn là công khai rõ ràng", "Không nên, dễ gây ra hiểu lầm và rạn nứt lòng tin", "Chỉ được đi chơi khi có sự tham gia của người yêu hoặc bạn chung"],
        weight: 5
    },
    {
        set_id: 5,
        text: "Thái độ của bạn đối với việc mua đồ trả góp hoặc vay tiêu dùng?",
        category: "G3_FINANCIAL_LIFESTYLE",
        sub_category: "spending_habit",
        options: ["Hoàn toàn phản đối, chỉ mua khi đã có đủ tiền mặt", "Chấp nhận trả góp 0% cho những sản phẩm thực sự cần thiết (điện thoại, máy tính)", "Thoải mái vay mượn để chi tiêu trước rồi trả nợ sau"],
        weight: 4
    },
    {
        set_id: 5,
        text: "Một ngày kỷ niệm hoàn hảo đối với bạn sẽ là:",
        category: "G4_INTIMACY_ROMANCE",
        sub_category: "love_language",
        options: ["Nhận được một bức thư tay đong đầy cảm xúc và những lời chúc ngọt ngào", "Một chuyến đi trốn ngắn ngày chỉ có hai người ở một nơi xa", "Một bữa tối lãng mạn tại nhà hàng sang trọng có nến và hoa"],
        weight: 5
    },
    {
        set_id: 5,
        text: "Phương pháp tốt nhất để tránh các mâu thuẫn lặp đi lặp lại là:",
        category: "G6_CONFLICT_RESOLUTION",
        sub_category: "communication_style",
        options: ["Đặt ra những quy tắc chung rõ ràng ngay từ đầu mối quan hệ", "Bỏ qua những chuyện nhỏ nhặt để tránh cãi vã", "Mỗi tuần dành một buổi ngồi lại phản hồi thẳng thắn cho nhau"],
        weight: 4
    },

    // === SET 6 ===
    {
        set_id: 6,
        text: "Nếu được mời làm MC hoặc thuyết trình trước toàn trường/công ty, bạn sẽ:",
        category: "G1_PERSONALITY",
        sub_category: "extroversion",
        options: ["Hào hứng đón nhận cơ hội tỏa sáng trước mọi người", "Lo lắng nhưng sẽ cố gắng tập luyện để hoàn thành", "Từ chối khéo vì không thích sự chú ý hướng vào mình"],
        weight: 4
    },
    {
        set_id: 6,
        text: "Khi bị người yêu hủy hẹn đột ngột vào phút chót vì lý do công việc, bạn cảm thấy:",
        category: "G1_PERSONALITY",
        sub_category: "emotional_stability",
        options: ["Tức giận, thất vọng và nghi ngờ tình cảm của họ dành cho mình", "Thông cảm vui vẻ và hẹn lại vào dịp khác gần nhất", "Hụt hẫng nhẹ nhưng tự tìm hoạt động vui vẻ khác cho bản thân"],
        weight: 5
    },
    {
        set_id: 6,
        text: "Về việc giáo dục con cái sau này, bạn muốn hướng con theo phương pháp nào?",
        category: "G2_CORE_VALUES",
        sub_category: "family_goal",
        options: ["Tự do trải nghiệm, khuyến khích phát triển tự nhiên", "Kỷ luật nghiêm khắc, định hướng rõ ràng ngay từ nhỏ", "Kết hợp cân bằng giữa học tập văn hóa và trải nghiệm kỹ năng sống"],
        weight: 5
    },
    {
        set_id: 6,
        text: "Hành động nào của đối phương khiến bạn cảm thấy bị phản bội lòng tin trầm trọng?",
        category: "G2_CORE_VALUES",
        sub_category: "loyalty_definition",
        options: ["Xóa tin nhắn trò chuyện bí mật với một người khác giới", "Tự ý mang số tiền tiết kiệm chung đi cho người khác vay mà không hỏi ý kiến", "Nói xấu bạn hoặc gia đình bạn sau lưng với người ngoài"],
        weight: 5
    },
    {
        set_id: 6,
        text: "Mức độ sẵn sàng chi tiêu của bạn cho việc nâng cao tri thức và phát triển bản thân?",
        category: "G3_FINANCIAL_LIFESTYLE",
        sub_category: "spending_habit",
        options: ["Sẵn sàng chi mạnh tay cho các khóa học, sách vở chất lượng", "Chỉ chi tiêu khi thực sự bắt buộc hoặc được công ty hỗ trợ", "Ưu tiên tự học và tìm tài nguyên miễn phí trên mạng"],
        weight: 4
    },
    {
        set_id: 6,
        text: "Món quà tinh thần nào từ người yêu khiến bạn cảm kích nhất?",
        category: "G4_INTIMACY_ROMANCE",
        sub_category: "love_language",
        options: ["Một playlist nhạc được tuyển chọn riêng đúng gu của bạn", "Đối phương lắng nghe chăm chú mọi tâm sự của bạn suốt nhiều giờ liền", "Một cái ôm chặt từ phía sau khi bạn đang làm việc mệt mỏi"],
        weight: 5
    },
    {
        set_id: 6,
        text: "Nếu cả hai cãi vã lớn và đối phương to tiếng, bạn phản ứng:",
        category: "G6_CONFLICT_RESOLUTION",
        sub_category: "communication_style",
        options: ["Cũng to tiếng lại để không bị lấn lướt", "Im lặng tuyệt đối và bỏ đi chỗ khác ngay lập tức", "Yêu cầu đối phương hạ giọng nói chuyện bình tĩnh, nếu không sẽ tạm dừng thảo luận"],
        weight: 4
    }
];

// Helper to determine mappings dynamically
function getMappings(subCategory, optionIndex) {
    switch (subCategory) {
        case "extroversion":
            if (optionIndex === 0) return [{ criteria_id: 'extroversion', score_delta: 0.8 }];
            if (optionIndex === 1) return [{ criteria_id: 'extroversion', score_delta: 0.2 }];
            return [{ criteria_id: 'extroversion', score_delta: -0.8 }];
        case "emotional_stability":
            if (optionIndex === 0) return [{ criteria_id: 'emotional_stability', score_delta: 0.8 }];
            if (optionIndex === 1) return [{ criteria_id: 'emotional_stability', score_delta: -0.8 }];
            return [{ criteria_id: 'emotional_stability', score_delta: -0.2 }];
        case "family_goal":
            if (optionIndex === 0) return [{ criteria_id: 'family_goal', score_delta: 0.9 }];
            if (optionIndex === 1) return [{ criteria_id: 'family_goal', score_delta: -0.8 }];
            return [{ criteria_id: 'family_goal', score_delta: 0.0 }];
        case "loyalty_definition":
            if (optionIndex === 0) return [{ criteria_id: 'loyalty_definition', score_delta: 0.8 }];
            if (optionIndex === 1) return [{ criteria_id: 'loyalty_definition', score_delta: 0.5 }];
            return [{ criteria_id: 'loyalty_definition', score_delta: 0.2 }];
        case "spending_habit":
            if (optionIndex === 0) return [{ criteria_id: 'spending_habit', score_delta: 0.8 }];
            if (optionIndex === 1) return [{ criteria_id: 'spending_habit', score_delta: 0.0 }];
            return [{ criteria_id: 'spending_habit', score_delta: -0.8 }];
        case "love_language":
            if (optionIndex === 0) return [{ criteria_id: 'love_language', score_delta: 0.5 }];
            if (optionIndex === 1) return [{ criteria_id: 'love_language', score_delta: 0.5 }];
            return [{ criteria_id: 'love_language', score_delta: 0.8 }];
        case "communication_style":
            if (optionIndex === 0) return [{ criteria_id: 'communication_style', score_delta: 0.8 }];
            if (optionIndex === 1) return [{ criteria_id: 'communication_style', score_delta: -0.5 }];
            return [{ criteria_id: 'communication_style', score_delta: 0.0 }];
        default:
            return [];
    }
}

// Meta hint lookup helper
function getMetaHint(subCategory, optionIndex) {
    return `${subCategory}_opt_${optionIndex + 1}`;
}

async function seed() {
    try {
        await sequelize.authenticate();
        console.log('Connected to DB for seeding Quiz V3...');

        // Disable foreign key checks to truncate
        await sequelize.query('SET FOREIGN_KEY_CHECKS = 0');
        await QuizOption.destroy({ where: {}, truncate: true });
        await QuizQuestion.destroy({ where: {}, truncate: true });
        await sequelize.query('SET FOREIGN_KEY_CHECKS = 1');

        let priority = 1;
        for (const q of questions) {
            const question = await QuizQuestion.create({
                content: q.text,
                category_id: q.category,
                sub_category: q.sub_category,
                weight: q.weight,
                difficulty: 'medium',
                priority: priority++,
                type: 'mcq',
                status: 'active',
                set_id: q.set_id
            });

            for (let i = 0; i < q.options.length; i++) {
                const optLabel = q.options[i];
                await QuizOption.create({
                    question_id: question.id,
                    label: optLabel,
                    mappings: getMappings(q.sub_category, i),
                    meta_hint: getMetaHint(q.sub_category, i)
                });
            }
        }

        console.log(`✅ Successfully seeded ${questions.length} QuizQuestions and their corresponding QuizOptions (6 sets total)!`);
        process.exit(0);
    } catch (error) {
        console.error('❌ Seeding Quiz V3 Failed:', error);
        process.exit(1);
    }
}

seed();
