begin
  require 'pp_sql'

  class String
    include PpSql::ToSqlBeautify
  end

rescue LoadError
  handle_load_error 'pp_sql'
end

