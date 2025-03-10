`ifndef LOG_SVH
`define LOG_SVH

`include "color.svh"

parameter int LOG_LEVEL_VERBOSE = 0;
parameter int LOG_LEVEL_DEBUG = (LOG_LEVEL_VERBOSE + 1);
parameter int LOG_LEVEL_INFO = (LOG_LEVEL_DEBUG + 1);
parameter int LOG_LEVEL_WARN = (LOG_LEVEL_INFO + 1);
parameter int LOG_LEVEL_ERROR = (LOG_LEVEL_WARN + 1);
parameter int LOG_LEVEL_FATAL = (LOG_LEVEL_ERROR + 1);

`ifndef LOG_LEVEL
parameter int LOG_LEVEL = LOG_LEVEL_INFO;
`endif

// Usage: LOG_INFO("message_tag", "message %d", 1); // => [time] [module_name] [message_tag] message 1
`define LOG(level, tag, msg, file = `__FILE__, line = `__LINE__) \
    if (LOG_LEVEL <= level) begin \
        if (tag == "") \
            $display("%0t [%m] %s [%s:%0d] [level]", $time, msg, file, line); \
        else \
            $display("(%0t) [%m] [%s] %s [%s:%0d] [level]", $time, tag, msg, file, line); \
    end

// use macro because it use file and line
`define LOG_VERBOSE(tag, msg) \
    `GRAY_COLOR \
    `LOG(LOG_LEVEL_VERBOSE, tag, msg) \
    `RESET_COLOR

`define LOG_DEBUG(tag, msg) \
    `WHITE_COLOR \
    `LOG(LOG_LEVEL_DEBUG, tag, msg) \
    `RESET_COLOR

`define LOG_INFO(tag, msg) \
    `GREEN_COLOR \
    `LOG(LOG_LEVEL_INFO, tag, msg) \
    `RESET_COLOR

`define LOG_WARN(tag, msg) \
    `YELLOW_COLOR \
    `LOG(LOG_LEVEL_WARN, tag, msg) \
    `RESET_COLOR

`define LOG_ERROR(tag, msg) \
    `RED_COLOR \
    `LOG(LOG_LEVEL_ERROR, tag, msg) \
    `RESET_COLOR

`define LOG_FATAL(tag, msg) `LOG(LOG_LEVEL_FATAL, tag, msg) $fatal;

`endif
