function [] = mimo( Nt, Nr )
    % Prepara as constantes da simulacao
    EbN0 = 0:0.2:20;
    SNR = 50;
    data = randi([0 1], Nt, 1);
    ber = zeros(1, length(EbN0));
    
    % Prepara os vetores utilizados na comunicao MIMO
    % x - dados enviados
    % y - dados recebidos
    % H channel impulse response matrix
    x = zeros(1, Nt);
    y = zeros(1, Nr);
    H = zeros(Nt, Nr); 
    
    for i = EbN0
        x = bpsk('encode', data);
        H = cirm(Nt, Nr);
    
        y = awgn(H * x, SNR);
        % Codigo para encontrar _x_ após no receptor
        
        % ber(i) = sum(uint8(y) ~= uint8(x)) / length(data);
    end
    
    semilogy(EbN0, ber, 'LineWidth', 2);
    grid on;
    title('MIMO - BER BPSK');
    legend('Medido');
    ylabel('BER');
    xlabel('Eb/N0');
     
end

