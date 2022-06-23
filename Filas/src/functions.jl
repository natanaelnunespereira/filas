export inserirCliente, momento, calcularIntervalo, calcularDuracao, processoChegada, calcularChegadaSegundos, processoAtendimento, calcularAtendimentoSegundos, dinamicaFuncionamento, resolucaoFila, tempoClientesFila, somaVetor, tempoMedioFila, numeroMedioFila, imprimirVetor

# Função para definir o intervalo, duração e momento do cliente ao chegar na fila.
function inserirCliente(fila::Fila, cliente::Cliente, intervalo::Float64, duracao::Float64)
    cliente.intervalo = intervalo
    cliente.duracao = duracao
    cliente.momento = momento(intervalo, fila)
    push!(fila.clientes, cliente)
    resolucaoFila(fila, cliente)
end

# Função para calcular o momento de chegada de cada cliente.
function momento(intervalo::Float64, fila::Fila)
    if length(fila.clientes) == 0
        intervalo += 1
    else 
        intervalo += fila.clientes[length(fila.clientes)].momento
    end

    return intervalo
end

# Soma dos intervalos dos clientes
function calcularIntervalo(fila::Fila)
    intervalo = 0.0

    for c in fila.clientes
        intervalo += c.intervalo
    end

    return intervalo
end

# Soma das durações dos clientes
function calcularDuracao(fila::Fila)
    duracao = 0.0

    for c in fila.clientes
        duracao += c.duracao
    end

    return duracao
end

# Função que calcula a chegada (clientes por minuto).
function processoChegada(fila::Fila)
    soma = calcularIntervalo(fila)
    media = length(fila.clientes)/soma

    return media
end

# Função que calcula a chegada (segundos por cliente).
function calcularChegadaSegundos(conversao::Float64)
    res = 60/conversao

    return res
end

# Função para calcular o atendimento (clientes por minuto).
function processoAtendimento(fila::Fila)
    soma = calcularDuracao(fila)
    media = length(fila.clientes)/soma

    return media
end

# Função que calcula o atendimento (segundos por cliente).
function calcularAtendimentoSegundos(conversao::Float64)
    res = 60/conversao
    
    return res
end

# Função para imprimir um vetor.
function imprimirVetor(vetor::Vector)
    for (i,v) in enumerate(vetor)
        if i > 1
            print(", ")
        end

        print(v)
    end
end

# Dinamica de funcionamento da fila
function dinamicaFuncionamento(fila::Fila)
    Clientes = []
    I = []
    D = []
    M = []
    IA = []
    FA = []

    for c in fila.clientes
        push!(Clientes, c.pessoa.id) 
        push!(I, c.intervalo) 
        push!(D, c.duracao)
        push!(M, c.momento)
        push!(IA, c.inicio_atendimento)
        push!(FA, c.fim_atendimento)  
    end
    
    print("Clientes: ") 
    imprimirVetor(Clientes)
    println()
    print("Intervalo: ") 
    imprimirVetor(I)
    println()
    print("Duracao: ") 
    imprimirVetor(D)
    println()
    print("Momento: ") 
    imprimirVetor(M)
    println()
    print("Inicio atendimento: ") 
    imprimirVetor(IA)
    println()
    print("Fim atendimento: ") 
    imprimirVetor(FA)
    println()
    println("Tempo medio na fila: ", tempoMedioFila(fila))
    println("Numero medio na fila: ", numeroMedioFila(fila))
end

# Função para realizar a resolução da fila, onde add o Inicio e fim do atendimento.
function resolucaoFila(fila::Fila, c::Cliente)
    tamanho = length(fila.clientes)

    if tamanho == 1
        MFUC = 0
    else
        MFUC = fila.clientes[tamanho-1].fim_atendimento
    end

    if c.momento >= MFUC
        c.inicio_atendimento = c.momento
    else
        c.inicio_atendimento = MFUC
    end

    c.fim_atendimento = c.inicio_atendimento + c.duracao
end

# Função para calcular o tempo que cada cliente permaneceu na fila.
function tempoClientesFila(fila::Fila)
    T = []

    for c in fila.clientes
        push!(T, c.inicio_atendimento - c.momento)
    end

    return T
end

# Função para somar os valores de um vetor.
function somaVetor(vetor::Vector)
    soma = 0
    
    for i in vetor
        soma += i
    end

    return soma
end

# Função que calcula o tempo médio na fila.
function tempoMedioFila(fila::Fila)
    T = tempoClientesFila(fila)
    soma = somaVetor(T)

    return soma/length(T)
end

# Função que calcula o numero médio na fila.
function numeroMedioFila(fila::Fila)
    T = tempoClientesFila(fila)
    soma = somaVetor(T)

    return soma/(fila.clientes[length(T)].fim_atendimento - 1)    
end