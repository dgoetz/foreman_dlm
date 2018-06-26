class DlmlocksController < ::ApplicationController
  include Foreman::Controller::AutoCompleteSearch

  before_action :setup_search_options, :only => :index
  before_action :find_resource, :only => [:show, :destroy, :release, :disable, :enable]

  def index
    @dlmlocks = resource_base_search_and_page(:host)
  end

  def show; end

  def destroy
    if @dlmlock.destroy
      process_success(
        :success_msg => _('Successfully deleted lock.'),
        :success_redirect => dlmlocks_path
      )
    else
      process_error
    end
  end

  def release
    if @dlmlock.update(host: nil)
      process_success(
        :success_msg => _('Successfully released lock.'),
        :success_redirect => dlmlocks_path
      )
    else
      process_error
    end
  end

  def disable
    if @dlmlock.update(enabled: false)
      process_success(
        :success_msg => _('Successfully disabled lock.'),
        :success_redirect => dlmlocks_path
      )
    else
      process_error
    end
  end

  def enable
    if @dlmlock.update(enabled: true)
      process_success(
        :success_msg => _('Successfully enabled lock.'),
        :success_redirect => dlmlocks_path
      )
    else
      process_error
    end
  end

  private

  def action_permission
    case params[:action]
    when 'release', 'disable', 'enable'
      :edit
    else
      super
    end
  end
end
