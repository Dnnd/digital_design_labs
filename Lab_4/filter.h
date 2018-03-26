
#ifndef DIGITAL_DESIGN_LABS_FILTER_H
#define DIGITAL_DESIGN_LABS_FILTER_H

#include <cstdint>
#include <vector>
#include <cmath>
#include <iostream>
#include <iomanip>




std::vector<std::int16_t> filtrate(const std::vector<std::int16_t> &coeffs, const std::vector<std::int16_t> &samples);

template<int Fraction, typename StorageType>
std::vector<StorageType> to_fixed_point(const std::vector<double> &values) {
    std::vector<StorageType> result;
    result.resize(values.size());
    for (auto i = 0; i < values.size(); ++i) {
        result[i] = static_cast<StorageType>(values[i] * (StorageType(1) << Fraction));
    }
    return std::move(result);
}

template<int Fraction, typename StorageType>
std::vector<double> from_fixed_point(const std::vector<StorageType> &values) {
    std::vector<double> result;
    result.resize(values.size());
    for (auto i = 0; i < values.size(); ++i) {
        result[i] = static_cast<double>(values[i]) / (StorageType(1) << Fraction);
    }
    return std::move(result);
};

#endif //DIGITAL_DESIGN_LABS_FILTER_H
