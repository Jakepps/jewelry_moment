# frozen_string_literal: true

require './jew/state_holders/list_state_notifier'
require_relative '../ui/master_input_form'
require_relative 'master_input_form_controller_create'
require_relative 'master_input_form_controller_edit'
require_relative '../master_db_data_source'
require 'win32api'

# Класс AuthorListController отвечает за управление списком
# авторов, используя различные методы для обновления данных и
# взаимодействия с пользовательским интерфейсом.
class MasterListController

  attr_reader :state_notifier;
  def initialize(view)
    LoggerHolder.instance.debug('MasterListController: init start')
    @view = view
    @state_notifier = ListStateNotifier.new
    @state_notifier.add_listener(@view)
    @author_rep = MasterDBDataSource.new

    @sort_columns = %w[MasterID FirstName LastName FatherName]
    @sort_by = @sort_columns.first

    @father_name_filter_columns = [nil, true, false]
    @father_name_filter = @father_name_filter_columns.first
    LoggerHolder.instance.debug('MasterListController: init done')
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

  # метод, который создает контроллер AuthorInputFormControllerEdit, представление AuthorInputForm, устанавливает связи
  # между ними и показывает модальное окно.
  def show_modal_add
    LoggerHolder.instance.debug('MasterListController: showing modal (add)')
    controller = MasterInputFormControllerCreate.new(self)
    view = MasterInputForm.new(controller)
    controller.set_view(view)
    view.create.show
  end

  def show_modal_edit(current_page, per_page, selected_row)
    # item_num = (current_page - 1) * per_page + selected_row

    item = @state_notifier.get(selected_row)

    controller = MasterInputFormControllerEdit.new(self, item)
    view = MasterInputForm.new(controller)
    controller.set_view(view)
    view.create.show
  end

  # метод, который получает выбранный элемент из state_notifier, удаляет его из базы данных и из state_notifier
  def delete_selected(current_page, per_page, selected_row)
    begin
      LoggerHolder.instance.debug('MasterListController: deleting selected master...')
      item = @state_notifier.get(selected_row)
      @author_rep.delete(item.master_id)
      @state_notifier.delete(item)
      LoggerHolder.instance.debug('MasterListController: deleting selected master done')
    rescue
      api = Win32API.new('user32', 'MessageBox', ['L', 'P', 'P', 'L'], 'I')
      api.call(0, "You cannot delete the master because it is associated with some product", "Error", 0)
      LoggerHolder.instance.debug('MasterListController: deleting selected master error')
    end
  end

  # метод, который получает список авторов из базы данных, устанавливает их в state_notifier
  # и обновляет пользовательский интерфейс
  def refresh_data(page, per_page)
    LoggerHolder.instance.debug('MasterListController: refreshing data...')
    items = @author_rep.get_list(per_page, page, @sort_by, 'ASC', @father_name_filter)
    @state_notifier.set_all(items)
    @view.update_student_count(@author_rep.count)
  end

  def sort(page, per_page, sort_index)
    LoggerHolder.instance.debug('MasterListController: filter start...')
    @sort_by = @sort_columns[sort_index]
    refresh_data(page, per_page)
    LoggerHolder.instance.debug('MasterListController: filter end.')
  end

  def filter_father_name(page, per_page, filter_index)
    LoggerHolder.instance.debug('MasterListController: filter start...')
    @father_name_filter = @father_name_filter_columns[filter_index]
    LoggerHolder.instance.debug('MasterListController: filter end.')
    refresh_data(page, per_page)
  end

  private

  def on_db_conn_error(error)
    LoggerHolder.instance.error('MasterListController: DB connection error:')
    LoggerHolder.instance.error(error.message)
    api = Win32API.new('user32', 'MessageBox', ['L', 'P', 'P', 'L'], 'I')
    api.call(0, "No connection to DB", "Error", 0)
    exit(false)
  end
end
