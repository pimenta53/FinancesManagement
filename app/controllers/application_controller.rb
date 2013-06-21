class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  include OrcamentosHelper
  include EstatisticasHelper
end
