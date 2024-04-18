#include "include/libgpiod_imp.h"
#include "include/thread_pool.h"

#include <functional>
#include <iostream>
#include <thread>

using namespace std;

int32_t main() {
    auto yt8512 = [&]() -> bool { // yt8512
        std::cout << "thread " << std::this_thread::get_id() <<
                     "started" << std::endl;

        GpioTools gpio;

        std::cout << "[ INFO ]Start yt8512 module" << std::endl;

        if (!gpio.add_chip("gpiochip3")) {
            std::cout << "[ERROR]Open chip3 yt8512 sector failed" << std::endl;

            return false;
        }

        if (!gpio.add_chip("gpiochip0")) {
            std::cout << "[ERROR]Open chip0 yt8512 sector failed" << std::endl;

            return false;
        }

        if (!gpio.add_line(gpio.get_chip_base()[0], 4)) {
            std::cout << "[ERROR]Open line4 yt8512 sector failed" << std::endl;

            return false;
        }

        if (!gpio.add_line(gpio.get_chip_base()[1], 1)) {
            std::cout << "[ERROR]Open line1 yt8512 sector failed" << std::endl;

            return false;
        }

        if (!gpio.add_line_request_input(gpio.get_line_base()[0]) &&
            !gpio.add_line_request_input(gpio.get_line_base()[1])) {
            std::cout << "[ERROR]Set line request failed" << std::endl;

            return false;
        }

        if (!gpio.set_line_value(gpio.get_line_base()[0], 1) &&
            !gpio.set_line_value(gpio.get_line_base()[1], 1)) {
            std::cout << "[ERROR]Set line request failed" << std::endl;

            return false;
        }

        system("ifconfig eth0 down;ifconfig eth0 up");

        return true;
    };

    auto sim7600 = [&]() -> bool {
        std::cout << "thread " << std::this_thread::get_id() <<
                     "started" << std::endl;

        GpioTools gpio;

        std::cout << "[ INFO ]Start sim7600 module" << std::endl;

        if (!gpio.add_chip("gpiochip0") &&
            !gpio.add_chip("gpiochip3")) {
            std::cout << "[ERROR]Chip sim7600 open failed" << std::endl;

            return false;
        }

        if (!gpio.add_line(gpio.get_chip_base()[0], 5)  &&
            !gpio.add_line(gpio.get_chip_base()[1], 15) &&
            !gpio.add_line(gpio.get_chip_base()[1], 1)) {
            std::cout << "[ERROR]Chip sim7600 line init failed" << std::endl;

            return false;
        }

        if (!gpio.add_line_request_input(gpio.get_line_base()[0]) &&
            !gpio.add_line_request_input(gpio.get_line_base()[1]) &&
            !gpio.add_line_request_input(gpio.get_line_base()[2])) {
            std::cout << "[ERROR]Line set request mode sim7600 failed" << std::endl;

            return false;
        }

        if (!gpio.set_line_value(gpio.get_line_base()[0], 1) &&
            !gpio.set_line_value(gpio.get_line_base()[1], 1) &&
            !gpio.set_line_value(gpio.get_line_base()[2], 1)) {
            std::cout << "[ERROR]Line set value sim7600 failed" << std::endl;

            return false;
        }

        return true;
    };

    std::function<bool()> yt = yt8512, sim = sim7600;

    {
        __raw_pool pool(std::thread::hardware_concurrency());

        pool.add_thread(yt);
        pool.add_thread(sim);
    }

    for (uint32_t i = 0; i < __raw_pool_result::result_pool_.size(); i++) {
        if (!__raw_pool_result::result_pool_[i])
            std::cout << "thread failed" << std::endl;
    }

    return 0;
}