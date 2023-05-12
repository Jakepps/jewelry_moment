# frozen_string_literal: true

require_relative 'views/main_window'
require './jew/util/logger_holder'

LoggerHolder.instance.level = Logger::DEBUG
MainWindow.new.create.show