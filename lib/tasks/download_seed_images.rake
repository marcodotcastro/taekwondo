require 'open-uri'

namespace :seeds do
  desc 'Download placeholder images for seeds'
  task download_images: :environment do
    puts "Criando diretório db/seeds..."
    FileUtils.mkdir_p('db/seeds')

    puts "Baixando imagens..."
    6.times do |i|
      image_path = "db/seeds/fighter#{i + 1}.jpg"
      unless File.exist?(image_path)
        # Usando o placeholder.com para gerar imagens
        width = 400
        height = 600
        image_url = "https://via.placeholder.com/#{width}x#{height}.jpg/808080/FFFFFF?text=Lutador+#{i + 1}"

        puts "Baixando imagem #{i + 1}..."
        File.open(image_path, 'wb') do |file|
          file.write URI.open(image_url).read
        end
      end
    end

    puts "Download concluído!"
  end
end