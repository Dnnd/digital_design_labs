#include <vector>
#include "fir_coeffs.h"
#include <iostream>
#include <fstream>
#include "filter.h"

int main(int argc, char **argv) {
    if (argc != 3) {
        return 0;
    }
    std::vector<double> coeffs;
    coeffs.resize(16);
    for (auto i = 0; i < 16; ++i) {
        coeffs[i] = NUM[i];
        std::cout << coeffs[i];
    }
    std::vector<double> samples;

    {
        std::ifstream ifs{argv[1]};
        samples.resize(100);
        for (auto i = 0; i < 100; ++i) {
            ifs >> samples[i];
        }
    }
    auto coeffs_fp = to_fixed_point<15, std::int16_t>(coeffs);
    auto samples_fp = to_fixed_point<15, std::int16_t>(samples);


    auto result_fp = filtrate(coeffs_fp,
                              samples_fp);

    {
        std::ofstream ofs{argv[2]};
        for (auto &&j : from_fixed_point<15>(result_fp)) {
            ofs << j << '\n';
        }
        ofs << std::endl;
    }


    return 0;
}