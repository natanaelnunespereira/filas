export Pessoa, Cliente, Servidor, Fila

# Estrutura que simboliza uma pessoa (cliente ou servidor) ou seja uma população.
struct Pessoa
    id::Int64
    nome::String
    
    Pessoa(args...) = new(args...)
    Pessoa(id) = new(id, "")
end

# Estrutura que simboliza um cliente, um cliente é uma pessoa e possui intervalo, momento e duração relacionado a fila.
mutable struct Cliente
    pessoa::Pessoa

    # Tempo de chegada do cliente em relação ao outro cliente.
    intervalo::Float64

    # Momento que o cliente entra na fila em relação ao tempo entre a abertura e finalização da fila.
    momento::Float64

    # Momento que é inciado o atendimento do cliente.
    inicio_atendimento::Float64

    # Momento que é finalizado o atendimento do cliente.
    fim_atendimento::Float64

    # Tempo de atendimento (aleatório).
    duracao::Float64

    Cliente(args...) = new(args...)
    Cliente(pessoa) = new(pessoa, 0, 0, 0, 0, 0)
end

# Estrutura que simboliza um servidor.
# Apenas para mapear.
struct Servidor
    pessoa::Pessoa
end

# Estrutura que simboliza uma fila, ela possui um conjunto de cliente (vetor).
struct Fila
    clientes::Vector{Cliente}
    
    Fila(args...) = new(args...)
    Fila() = new(Vector{Cliente}(undef,0))
end