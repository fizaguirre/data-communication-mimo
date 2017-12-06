function [ ] = plot_data( ebn0, bzf, bnc, bsnc )

    semilogy(ebn0, bzf, 'r', ebn0, bnc, 'g', ebn0, bsnc, 'b', 'LineWidth', 2);
    grid on;
    title('MIMO - BER BPSK');
    legend('Zero Forcing', 'Nulling Canceling', 'Sorted Nulling Canceling');
    ylabel('BER');
    xlabel('Eb/N0');
    drawnow;

end

