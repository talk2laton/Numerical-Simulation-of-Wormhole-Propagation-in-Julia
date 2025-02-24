using Genie

params = Params();
push!(params[:response].headers, "Cache-Control" =>"no-cache")
params[:respons].status = 201
html("Hello"; params)