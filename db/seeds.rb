puts "Limpando banco de dados..."
Match.destroy_all
Fighter.destroy_all

# Lista de lutadores
lutadores = [
  ["Gabriel Silva", "Peso Leve", 68],
  ["Lucas Oliveira", "Peso Leve", 67],
  ["Maria Santos", "Peso Médio", 73],
  ["Ana Costa", "Peso Médio", 72],
  ["Pedro Ferreira", "Peso Pesado", 85],
  ["João Mendes", "Peso Pesado", 84]
]

puts "\nCriando lutadores..."
created_fighters = lutadores.map do |nome, categoria, peso|
  fighter = Fighter.create!(
    name: nome,
    category: categoria,
    weight: peso
  )
  puts "Criado lutador: #{fighter.name}"
  fighter
end

puts "\nCriando lutas..."
matches = [
  {
    fighter1: created_fighters[0],
    fighter2: created_fighters[1],
    duration: 120,
    status: :pending
  },
  {
    fighter1: created_fighters[2],
    fighter2: created_fighters[3],
    duration: 120,
    status: :in_progress,
    started_at: Time.current,
    fighter1_score: 5,
    fighter2_score: 3,
    fighter1_penalties: 1,
    fighter2_penalties: 0
  },
  {
    fighter1: created_fighters[4],
    fighter2: created_fighters[5],
    duration: 120,
    status: :finished,
    started_at: 1.hour.ago,
    fighter1_score: 8,
    fighter2_score: 7,
    fighter1_penalties: 2,
    fighter2_penalties: 1
  }
]

matches.each do |match_data|
  match = Match.create!(match_data)
  puts "Criada luta: #{match.fighter1.name} vs #{match.fighter2.name} (#{match.status})"
end

puts "\nSeed finalizado com sucesso!"
puts "Foram criados:"
puts "- #{Fighter.count} lutadores"
puts "- #{Match.count} lutas"
puts "\nObs: Os lutadores foram criados sem fotos. Use a interface da aplicação para adicionar fotos se necessário."