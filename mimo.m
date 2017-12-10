%%
% Função principal do trabalho. Executa a simulação propriamente dita.
%
% Nt: número de antenas transmissoras (colunas da matriz H)
% Nr: número de antenas receptoras (linhas da matriz H)
% num_bits: número de bits transmitidos para cada Eb/N0
%
function [] = mimo( Nt, Nr, num_bits)
    
    % Parâmetro da simulação
    MaxEbN0_dB = 10; % máximo Eb/N0 simulado (em dB)
    
    % Prepara as constantes da simulacao
    Eb = 1;
    EbN0_dB = 0:1:MaxEbN0_dB;
    EbN0_lin = 10 .^ (EbN0_dB/10);
    NP = Eb ./ (EbN0_lin);
    NA = sqrt(NP); %amplitude é a raiz quadrada da potência
    
    data = bpsk(num_bits);
    
    % Prepara os vetores utilizados na comunicao MIMO
    % x - dados enviados
    % y - dados recebidos
    x = zeros(Nt, 1);
    y = zeros(Nr, 1);
    
    % BER para cada um dos três algoritmos
    ber_zf  = zeros(1, length(EbN0_lin));
    ber_nc  = zeros(1, length(EbN0_lin));
    ber_snc = zeros(1, length(EbN0_lin));
    
    % "Inicia" a janela do plot
    % (vide documentação dessa função)
    plot_data(EbN0_dB, ber_zf, ber_nc, ber_snc);
    
    for i = 1:length(EbN0_lin)
        
        % Bits estimados pelo receptor para cada algoritmo
        rec_data_zf  = [];
        rec_data_nc  = [];
        rec_data_snc = [];
        
        for j = 1:Nt:length(data)
            
            % Chunk de dados para transmitir
            x = data(j:j+Nt-1); % bpsk('encode', data(j:j+Nt-1));
            
            % Gera uma matriz H para cada chunk de dados transmitidos
            H = cirm(Nr, Nt);

            % Ruído
            n = NA(i)*complex(randn(1,Nr), randn(1,Nr))*sqrt(0.5);
            y = (H * x) + n';
            
            
            % Detecção MIMO com os 3 algoritmos
            
            x_ = zero_forcing(H, y);
            rec_data_zf = [rec_data_zf ; x_];
            
            x_ = nulling_and_canceling(H,y);
            rec_data_nc = [rec_data_nc ; x_];
            
            x_ = sorted_nulling_and_canceling(H, y);
            rec_data_snc = [rec_data_snc ; x_];
        end
        
        % Computa do BER para algoritmo para esse valor de Eb/N0 em particular
        ber_zf(i)  = sum(sign(data') ~= rec_data_zf') / length(data);
        ber_nc(i)  = sum(sign(data') ~= rec_data_nc') / length(data);
        ber_snc(i) = sum(sign(data') ~= rec_data_snc') / length(data);
        
        % Atualiza o plot
        plot_data(EbN0_dB, ber_zf, ber_nc, ber_snc);
    end
    
    plot_data(EbN0_dB, ber_zf, ber_nc, ber_snc);
    
    % Para fins de inspeção dos BER's
    EbN0_dB, ber_zf, ber_nc, ber_snc
    
end

