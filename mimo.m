function [] = mimo( Nt, Nr )
    % Prepara as constantes da simulacao
    MaxEbN0 = 10;
    Eb = 1;
    EbN0 = 1:1:MaxEbN0;
    EbN0_lin = MaxEbN0 .^ (EbN0/MaxEbN0);
    NP = Eb ./ (EbN0_lin);
    NA = sqrt(NP); %amplitude � a raiz quadrada da pot�ncia
    
    nb = 50000;
    data = complex(2*randi([0 1], nb, 1)-1);
    
    
    % Prepara os vetores utilizados na comunicao MIMO
    % x - dados enviados
    % y - dados recebidos
    % H channel impulse response matrix
    x = zeros(Nt, 1);
    y = zeros(Nt, 1);
    H = zeros(Nt, Nr);
    
    ber_zf = zeros(1, length(EbN0));
    ber_nc = zeros(1, length(EbN0));
    
    rec_data_nc = [];
    rec_data_zf = [];
    
    for i = EbN0
        for j = 1:Nt:length(data)
            x = data(j:j+Nt-1); % bpsk('encode', data(j:j+Nt-1));
            H = cirm(Nt, Nr);

            % ruido
            n = NA(i)*complex(randn(1, Nt), randn(1, Nt))*sqrt(0.5);
            y = (H * x) + n';
            
            
            %zero-forcing
            x_ = slice(zero_forcing(H, y));
            %rec_data_zf = vertcat(rec_data_zf, x_);
            rec_data_zf = [rec_data_zf ; x_];
            
            x_ = nulling_and_canceling(H,y);
            rec_data_nc= [rec_data_nc ; x_];
        end
        ber_zf(i) = sum(sign(data') ~= rec_data_zf') / length(data);
        ber_nc(i) = sum(sign(data') ~= rec_data_nc') / length(data);
        rec_data_zf = [];
        rec_data_nc = [];
    end
    
    semilogy(EbN0, ber_zf, 'r*', EbN0, ber_nc, 'go', 'LineWidth', 2);
    grid on;
    title('MIMO - BER BPSK');
    legend('Medido');
    ylabel('BER');
    xlabel('Eb/N0');
     
end

