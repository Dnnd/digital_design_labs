#include <vector>
#include "fir_coeffs.h"
#include <iostream>
#include <fstream>
#include "filter.h"
#include <bitset>

int main(int argc, char **argv) {
    std::vector<double> coeffs;
    coeffs.resize(16);
    for (auto i = 0; i < 16; ++i) {
        coeffs[i] = NUM[i];
        std::cout << coeffs[i] << ' ';
    }

    std::ifstream ifs{"../const.txt"};
    std::vector<double> samples;
    samples.resize(100);
    for (auto i = 0; i < 100; ++i) {
        ifs >> samples[i];
    }
    auto coeffs_fp = to_fixed_point<15, std::int16_t>(coeffs);
    auto samples_fp = to_fixed_point<15, std::int16_t>(samples);


    std::cout << '\n';

    auto result_fp = filtrate(coeffs_fp,
                              samples_fp);


    for (auto &&j : from_fixed_point<15>(result_fp)) {
        std::cout << j << ' ';
    }

    std::cout << std::endl;

    return 0;
}