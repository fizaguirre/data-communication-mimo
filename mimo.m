function [] = mimo( Nt, Nr, num_bits)
    % Prepara as constantes da simulacao
    MaxEbN0 = 10;
    Eb = 1;
    EbN0 = 1:1:MaxEbN0;
    EbN0_lin = MaxEbN0 .^ (EbN0/MaxEbN0);
    NP = Eb ./ (EbN0_lin);
    NA = sqrt(NP); %amplitude é a raiz quadrada da potência
    
    data = bpsk(num_bits);
    
    
    % Prepara os vetores utilizados na comunicao MIMO
    % x - dados enviados
    % y - dados recebidos
    % H channel impulse response matrix
    x = zeros(Nt, 1);
    y = zeros(Nt, 1);
    H = zeros(Nt, Nr);
    
    ber_zf = zeros(1, length(EbN0));
    ber_nc = zeros(1, length(EbN0));
    ber_snc = zeros(1, length(EbN0));
    
    plot_data(EbN0, ber_zf, ber_nc, ber_snc);
    
    rec_data_nc = [];
    rec_data_zf = [];
    rec_data_snc = [];
    
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
            rec_data_nc = [rec_data_nc ; x_];
            
            x_ = sorted_nulling_and_canceling(H, y);
            rec_data_snc = [rec_data_snc ; x_];
        end
        ber_zf(i) = sum(sign(data') ~= rec_data_zf') / length(data);
        ber_nc(i) = sum(sign(data') ~= rec_data_nc') / length(data);
        ber_snc(i) = sum(sign(data') ~= rec_data_snc') / length(data);
        
        plot_data(EbN0, ber_zf, ber_nc, ber_snc);
        
        rec_data_zf = [];
        rec_data_nc = [];
        rec_data_snc = [];
    end
    
    plot_data(EbN0, ber_zf, ber_nc, ber_snc);
     
end

