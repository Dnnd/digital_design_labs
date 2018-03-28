#include "filter.h"

std::vector<std::int16_t> filtrate(const std::vector<std::int16_t> &coeffs, const std::vector<std::int16_t> &samples) {
    std::vector<std::int16_t> result;
    result.resize(samples.size());
    for (auto i = 0; i < samples.size(); ++i) {
        std::int32_t accumulator = 0;
        for (auto j = 0; j < coeffs.size(); ++j) {
            if (i - j >= 0) {
                accumulator += static_cast<std::int32_t>(coeffs[j]) * samples[i - j];
            }
        }
        result[i] = static_cast< std::int16_t>(accumulator >> 15);
    }

    return std::move(result);
}

