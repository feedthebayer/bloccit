module Paginate

  def paginate(input = { page: 1, per_page: 10 } )
    page     = input[:page] || 1
    per_page = input[:per_page]
    offset   = per_page * (page - 1)
    limit(per_page).offset(offset)
  end
end
