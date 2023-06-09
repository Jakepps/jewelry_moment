# # frozen_string_literal: true
#
# require './jew/views/main_window'
# require './jew/repositories/student_repository'
# require './jew/repositories/adapters/db_source_adapter'
# require './jew/repositories/containers/data_list_student_short'
# require './jew/state_holders/list_state_notifier'
# require_relative '../author_db_data_source'
# require 'win32api'
#
# class AuthorController
#
#
#   def initialize(view)
#     @view = view
#     @state_notifier = ListStateNotifier.new
#     @state_notifier.add_listener(@view)
#     @author_rep = AuthorDBDataSource.new
#   end
#
#   def edit (number)
#     master = @state_notifier.get(number)
#     puts master.id
#     # @view.show_edit_dialog(master)
#   end
#
#   def add (number)
#     master = @state_notifier.get(number)
#     puts master
#     # @view.show_add_dialog(master)
#   end
#
#
#   def remove (number)
#     master = @state_notifier.get(number)
#     puts master
#     # @view.show_remove_dialog(master)
#   end
#
#   def refresh_data(page, per_page)
#     items = @author_rep.get_list(per_page, page, 'FirstName', 'ASC' )
#     @state_notifier.set_all(items)
#     @view.update_student_count(@author_rep.count)
#   end
#
#   def refresh()
#     items = @author_rep.get_list(per_page, page, 'FirstName', 'ASC' )
#     @state_notifier.set_all(items)
#     @view.update_student_count(@author_rep.count)
#   end
#
#   def on_db_conn_error
#     api = Win32API.new('user32', 'MessageBox', ['L', 'P', 'P', 'L'], 'I')
#     api.call(0, "No connection to DB", "Error", 0)
#     exit(false)
#   end
# end
