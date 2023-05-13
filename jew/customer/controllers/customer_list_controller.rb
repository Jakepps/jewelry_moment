# frozen_string_literal: true

require './jew/state_holders/list_state_notifier'
require_relative '../ui/customer_input_form'
require_relative 'customer_input_form_controller_create.rb'
require_relative 'customer_input_form_controller_edit'
require_relative '../customer_db_data_source'
require 'win32api'

class CustomerListController

  attr_reader :state_notifier
  def initialize(view)
    LoggerHolder.instance.debug('CustomerListController: init start')
    @view = view
    @state_notifier = ListStateNotifier.new
    @state_notifier.add_listener(@view)
    @publisher_rep = CustomerDBDataSource.new

    @sort_columns = %w[CustomerID Name Email]
    @sort_by = @sort_columns.first

    @email_filter_columns = [nil, true, false]
    @email_filter = @email_filter_columns.first
    LoggerHolder.instance.debug('CustomerListController: init done')
  end



  def on_view_created
    # begin
    #   @student_rep = StudentRepository.new(DBSourceAdapter.new)
    # rescue Mysql2::Error::ConnectionError
    #   on_db_conn_error
    # end
  end

  def show_view
    @view.create.show
  end

  def show_modal_add
    LoggerHolder.instance.debug('CustomerListController: showing modal (add)')
    controller = CustomerInputFormControllerCreate.new(self)
    view = CustomerInputForm.new(controller)
    controller.set_view(view)
    view.create.show
  end

  def show_modal_edit(current_page, per_page, selected_row)
    # item_num = (current_page - 1) * per_page + selected_row

    item = @state_notifier.get(selected_row)

    controller = CustomerInputFormControllerEdit.new(self, item)
    view = CustomerInputForm.new(controller)
    controller.set_view(view)
    view.create.show
  end

  def delete_selected(current_page, per_page, selected_row)
    begin
      LoggerHolder.instance.debug('CustomerListController: deleting selected master')
      item = @state_notifier.get(selected_row)
      @publisher_rep.delete(item.publisher_id)
      @state_notifier.delete(item)
    rescue
      api = Win32API.new('user32', 'MessageBox', ['L', 'P', 'P', 'L'], 'I')
      api.call(0, "You cannot delete the customer because it is associated with some product", "Error", 0)
    end
  end

  def refresh_data(page, per_page)
    LoggerHolder.instance.debug('CustomerListController: refreshing data...')
    items = @publisher_rep.get_list(per_page, page, @sort_by, 'ASC', @email_filter)
    @state_notifier.set_all(items)
    @view.update_student_count(@publisher_rep.count)
  end

  def sort(page, per_page, sort_index)
    LoggerHolder.instance.debug('CustomerListController: filter start...')
    @sort_by = @sort_columns[sort_index]
    refresh_data(page, per_page)
    LoggerHolder.instance.debug('CustomerListController: filter end.')
  end

  def filter_email(page, per_page, filter_index)
    LoggerHolder.instance.debug('CustomerListController: filter start...')
    @email_filter = @email_filter_columns[filter_index]
    refresh_data(page, per_page)
    LoggerHolder.instance.debug('CustomerListController: filter end.')
  end


  private

  def on_db_conn_error(error)
    LoggerHolder.instance.error('CustomerListController: DB connection error:')
    LoggerHolder.instance.error(error.message)
    api = Win32API.new('user32', 'MessageBox', ['L', 'P', 'P', 'L'], 'I')
    api.call(0, "No connection to DB", "Error", 0)
    exit(false)
  end
end
