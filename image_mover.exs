# list all files
# filter for jpg bmp png gif
# copy files to images subdir

#File.cd("imagetest")
filelist = File.ls!
#IO.inspect File.cwd
#IO.inspect filelist

image_regex = ~r/\.(jpg|png|bmp|gif)$/
imagelist = filelist |> Enum.filter(&(Regex.match?(image_regex, &1)))
IO.inspect imagelist

case File.mkdir("./images") do
    :ok         -> IO.puts "./images directory created successfully."
    {:error, _} -> IO.puts "Could not create ./images directory."
end

Enum.each(imagelist, fn filename ->
    case File.rename(filename, "./images/#{filename}") do
        :ok         -> IO.puts "#{filename} successfully moved to images directory."
        {:error, _} -> IO.puts "Error moving #{filename} to images directory."
    end
end)