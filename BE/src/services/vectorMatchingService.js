/**
 * LoveSense Matching Engine - Vector Similarity Service
 */

class VectorMatchingService {
    /**
     * Tính toán Cosine Similarity giữa hai Vector
     * @param {number[]} vecA - Vector của User đang tìm kiếm
     * @param {number[]} vecB - Vector của ứng viên
     * @returns {number} - Điểm từ 0.0 đến 1.0
     */
    calculateSimilarity(vecA, vecB) {
        if (!vecA || !vecB || vecA.length !== vecB.length) return 0;

        let dotProduct = 0;
        let normA = 0;
        let normB = 0;

        for (let i = 0; i < vecA.length; i++) {
            dotProduct += vecA[i] * vecB[i];
            normA += vecA[i] * vecA[i];
            normB += vecB[i] * vecB[i];
        }

        const magnitude = Math.sqrt(normA) * Math.sqrt(normB);
        if (magnitude === 0) return 0;
        
        return dotProduct / magnitude;
    }

    /**
     * Tìm kiếm Top người dùng phù hợp nhất
     * @param {number[]} targetVector - Vector gốc của User A
     * @param {Object[]} candidates - Danh sách các Profile kèm vector
     * @param {number} topK - Số lượng kết quả muốn lấy
     */
    findTopMatches(targetVector, candidates, topK = 20) {
        const scoredMatches = candidates.map(candidate => {
            let candidateVector = candidate.preference_vector;
            
            // Parse nếu vector đang được lưu dưới dạng chuỗi JSON
            if (typeof candidateVector === 'string') {
                try { candidateVector = JSON.parse(candidateVector); }
                catch (e) { candidateVector = null; }
            }

            const score = this.calculateSimilarity(targetVector, candidateVector);
            
            return {
                user_id: candidate.user_id,
                display_name: candidate.display_name,
                match_score: parseFloat(score.toFixed(4)),
                // Giữ lại các metadata cần thiết
                bio: candidate.bio,
                main_photo: candidate.main_photo
            };
        });

        // Sắp xếp giảm dần theo điểm số và lấy Top K
        return scoredMatches
            .sort((a, b) => b.match_score - a.match_score)
            .slice(0, topK);
    }
}

module.exports = new VectorMatchingService();
