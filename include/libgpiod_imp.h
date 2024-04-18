#ifndef __LIB_GPIO
#define __LIB_GPIO

#include <gpiod.h>

#include <cstdint>
#include <string>
#include <vector>

#include "unistd.h"

//using namespace std;

namespace types {
    //typedef string chip_path_t;
    typedef gpiod_chip  chip_t;
    typedef gpiod_line  line_t;
}

class GpioTools {
private:    
    std::vector<types::chip_t *> chip;
    std::vector<types::line_t *> line;

public:
    GpioTools(const GpioTools&);
    GpioTools();

    bool add_chip(const char *);
    bool add_line(types::chip_t *, const uint32_t);
    bool add_line_request_input(types::line_t *);
    bool add_line_request_output(types::line_t *, uint32_t = 0);

    [[nodiscard]] int32_t get_line_value(types::line_t *getLine_) const { return gpiod_line_get_value(getLine_); }; 
    [[nodiscard]] vector<types::chip_t *> get_chip_base() const { return chip; }
    [[nodiscard]] vector<types::line_t *> get_line_base() const { return line; }

    bool set_line_value(types::line_t *, bool);
    
    void close_chip(types::chip_t *);
    void close_line(types::line_t *);

    void close_all_chip();
    void close_all_line();

    ~GpioTools();
};

#endif // __LIB_GPIO