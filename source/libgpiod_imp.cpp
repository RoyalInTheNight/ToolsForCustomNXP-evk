#include "../include/libgpiod_imp.h"

GpioTools::GpioTools(const GpioTools& tools_) {
    this->chip = tools_.chip;
    this->line = tools_.line;
}

GpioTools::GpioTools() {}

bool GpioTools::add_chip(const char *path_) {
    chip.push_back(
        gpiod_chip_open_by_name(
            path_
        )
    );

    if (!chip[chip.size() - 1])
        return false;

    return true;
}

bool GpioTools::add_line(types::chip_t *chip_, const uint32_t line_value_) {
    line.push_back(
        gpiod_chip_get_line(
              chip_, 
            line_value_)  
    );

    if (!line[line.size() - 1])
        return false;

    return true;
}

bool GpioTools::add_line_request_input(types::line_t *line_) {
    if (gpiod_line_request_input(
            line_, 
        "input_GPIO_line"
    ))
        return false;

    return true;
}

bool GpioTools::add_line_request_output(types::line_t *line_, uint32_t output_value_) {
    if (gpiod_line_request_output(
               line_, 
           "output_GPIO_line", 
        output_value_
    ))
        return false;

    return true;
}

bool GpioTools::set_line_value(types::line_t *line_, bool value_) {
    if (gpiod_line_set_value(
         line_, 
        value_
    ))
        return false;

    return true;
}

void GpioTools::close_chip(types::chip_t *chip_) {
    gpiod_chip_close(
        chip_
    );
}

void GpioTools::close_line(types::line_t *lines_) {
    gpiod_line_release(
        lines_
    );
}

void GpioTools::close_all_chip() {
    for (uint32_t i = 0; i < chip.size(); i++)
        close_chip(chip[i]);

    chip.clear();
}

void GpioTools::close_all_line() {
    for (uint32_t i = 0; i < line.size(); i++)
        close_line(line[i]);

    line.clear();
}