# frozen_string_literal: true

require 'glimmer-dsl-libui'
require_relative 'tab_students'
require './lib/master/ui/master_list_view'
require './lib/customer/ui/customer_list_view'

class MainWindow
  include Glimmer

  def initialize
    @view_tab_students = TabStudentsView.new
  end

  def create
    window('Ювелирная мастерская', 900, 500) {
      tab {
        tab_item('Мастера') {
          MasterListView.new.create
        }
        tab_item('Заказчики') {
          CustomerListView.new.create
        }
        #
        #
        # tab_item('Студенты') {
        #   @view_tab_students.create
        # }
      }
    }
  end
end
