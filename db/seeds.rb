State.create!([
  { uf: 'AC', name: "Acre" },
  { uf: 'AL', name: "Alagoas" },
  { uf: 'AM', name: "Amazonas" },
  { uf: 'AP', name: "Amapá" },
  { uf: 'BA', name: "Bahia" },
  { uf: 'CE', name: "Ceará" },
  { uf: 'DF', name: "Distrito Federal" },
  { uf: 'ES', name: "Espírito Santo" },
  { uf: 'GO', name: "Goiás" },
  { uf: 'MA', name: "Maranhão" },
  { uf: 'MG', name: "Minas Gerais" },
  { uf: 'MS', name: "Mato Grosso do Sul" },
  { uf: 'MT', name: "Mato Grosso" },
  { uf: 'PA', name: "Pará" },
  { uf: 'PB', name: "Paraíba" },
  { uf: 'PE', name: "Pernambuco" },
  { uf: 'PI', name: "Piauí" },
  { uf: 'PR', name: "Paraná" },
  { uf: 'RJ', name: "Rio de Janeiro" },
  { uf: 'RN', name: "Rio Grande do Norte" },
  { uf: 'RO', name: "Rondônia" },
  { uf: 'RR', name: "Roraima" },
  { uf: 'RS', name: "Rio Grande do Sul" },
  { uf: 'SC', name: "Santa Catarina" },
  { uf: 'SE', name: "Sergipe" },
  { uf: 'SP', name: "São Paulo" },
  { uf: 'TO', name: "Tocantins" },
])

if ENV['SAMPLE_DATA'] == '1'
  Shop.create!(name: 'BodyStore').places.create!({
    name: 'Barra Shopping Sul',
    address_line_1: 'Av. Diário de Notícias, 300',
    address_line_2: 'Loja 1077, Piso Jockey',
    city: 'Porto Alegre',
    district: 'Cristal',
    postal_code: '90810-080',
    main_phone: '(51) 3028-1092',
    home_page: 'www.bodystore.com.br',
    lat: -30.083447,
    lon: -51.246942,
    images: [
      'https://fbcdn-profile-a.akamaihd.net/hprofile-ak-snc4/276522_161635053886727_290275592_n.jpg'
    ],
    description: 'Empório Body Store',
    email: 'bodystorebarrasul@emporiobodystore.com.br',
    categories: ['Cosmetics Store', 'Other'],
    state: State.uf!(:RS),
  })
end
