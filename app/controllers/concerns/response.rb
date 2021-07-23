module Response
  def json_response(object, status = :ok)
    render json: formatted_response(object), status: status
  end

  def formatted_response(object)
    {
      header: {
        page: object.current_page,
        limit_value: object.limit_value,
        total_pages: object.total_pages,
        total_count: object.total_count,
      },
      data: object
    }
  end
end
