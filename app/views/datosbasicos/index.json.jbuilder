json.array!(@datosbasicos) do |datosbasico|
  json.extract! datosbasico, :id, :titulo, :seccion, :descripcion
  json.url datosbasico_url(datosbasico, format: :json)
end
