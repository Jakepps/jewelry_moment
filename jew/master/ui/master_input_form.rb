# frozen_string_literal: true

require 'glimmer-dsl-libui'
require_relative '../controllers/master_input_form_controller_create'
require './jew/models/master'
require './jew/util/logger_holder'
require 'win32api'

class MasterInputForm
  include Glimmer

  def initialize(controller, existing_student = nil)
    @item = existing_student.to_hash unless existing_student.nil?
    @controller = controller
    @entries = {}
    LoggerHolder.instance.debug('MasterInputForm: initialized')
  end

  def on_create
    @controller.on_view_created
  end

  def create
    @root_container = window('Мастер', 300, 70) {
      resizable false

      vertical_box {
        @student_form = form {
          stretchy false

          fields = [[:first_name, 'Имя мастера'], [:last_name, 'Фамилия мастера'], [:father_name, 'Отчество мастера']]

          fields.each do |field|
            @entries[field[0]] = entry {
              label field[1]
            }
          end
        }

        button('Сохранить') {
          stretchy false

          on_clicked {
            values = @entries.transform_values { |v| v.text.force_encoding("utf-8").strip }
            values.transform_values! { |v| v.empty? ? nil : v}

            @controller.process_fields(values)
            LoggerHolder.instance.debug('MasterInputForm: adding/edit master to DB')
          }
        }
      }
    }
    on_create
    @root_container
  end

  def set_value(field, value)
    return unless @entries.include?(field)

    @entries[field].text = value
  end

  def make_readonly(*fields)
    fields.each do |field|
      @entries[field].read_only = true
    end
  end

  def close
    @root_container.destroy
  end
end
