module Paginate

  def paginate(input = { page: 1, per_page: 10 } )
    # Ensure :page != nil
    input[:page] ||= 1

    # page = input[:page]
    # multiplier = page - 1
    # offset = per_page * multiplier
    # limit(per_page).offset(offset)
    limit(input[:per_page]).offset(input[:per_page] * (input[:page] - 1))
  end
end
