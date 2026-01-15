clear all
close all
%%%%%パラメータの定義
Tgoal = 1*60*50;%%% Simulation time [s]
Tvpp  = 10;%%% 施設運用問題のサンプリング時間 [s]
Ts = 1;%%% 機器運転問題のサンプリング時間 [s]
gammaX = 20;% gamma

%%%%% 施設1のパラメータ
wF1 = 3;% 重み係数
Pd1 = 0;% 施設が達成したい運用計画[kW]
min_P1 =-100;% 出力可能な上限値[kW]
max_P1 = 50;% 出力可能な下限値[kW]
gamma1 = 60;% gamma
upper_price1 = 80;% 価格の上限値
lower_price1 = -80;% 価格の下限値
%%%%% 蓄電機器のパラメータ
w_1s = 1;% 重み係数
min_pi1s = -40;% 出力の下限値[kW]
max_pi1s = 40;% 出力の上限値[kW]
Bcm_1s = 50;% 蓄電容量[kWh]
Bcs_1s = Bcm_1s*0.5;% 初期蓄電容量[kWh]
Delay_1S = 8.4;% シミュレーション開始時の出力[kW]
%%%%% 電気自動車のパラメータ
w_1EV = 4;% 重み係数
min_pi1EV =-10;% 出力の下限値[kW]
max_pi1EV = 10;% 出力の上限値[kW]
Bcm_1EV = 24;% 蓄電容量[kWh]
Bcs_1EV = Bcm_1s*0.5;% 初期蓄電容量[kWh]
Delay_1EV = 2.1;% シミュレーション開始時の出力[kW]

%%%%% 施設2のパラメータ
wF2 = 1;%%% 重み係数
Pd2 = 0;%%% 施設が達成したい運用計画[kW]
min_P2 =-300;%%% 出力可能な上限値[kW]
max_P2 = 420;%%% 出力可能な下限値[kW]
gamma2 = 60;%%%
upper_price2 = 1380;%%% 価格の上限値
lower_price2 = -60;%%% 価格の下限値
%%%%% 発電機器のパラメータ
w_2g = 6;% 重み係数
min_pi2g = 0;% 出力の下限値[kW]
max_pi2g = 120;% 出力の上限値[kW]
Pd_2g = 115;% 発電計画[kW]
Delay_2G = 113.2;% シミュレーション開始時の出力[kW]
%%%%% 蓄電機器のパラメータ
w_2s = 0.1;% 重み係数
min_pi2s = -300;% 出力の下限値[kW]
max_pi2s = 300;% 出力の上限値[kW]
Bcm_2s = 300;% 蓄電容量[kWh]
Bcs_2s = Bcm_2s*0.5;% 初期蓄電容量[kWh]
Delay_2S = -110.2;% シミュレーション開始時の出力[kW]

%%%%% 施設3のパラメータ
wF3 = 3;%%% 重み係数
Pd3 = 0;%%% 施設が達成したい運用計画[kW]
min_P3 =-100;%%% 出力可能な上限値[kW]
max_P3 = 100;%%% 出力可能な下限値[kW]
gamma3 = 60;%%%
upper_price3 = 570;%%% 価格の上限値
lower_price3 = -160;%%% 価格の下限値
%%%%% 発電機器のパラメータ
w_3g = 3;% 重み係数
min_pi3g = 0;% 出力の下限値[kW]
max_pi3g = 100;% 出力の上限値[kW]
Pd_3g = 95;% 発電計画[kW]
Delay_3G = 91.5;% シミュレーション開始時の出力[kW]
%%%%% 消費機器のパラメータ
w_3c = 1;% 重み係数
min_pi3c =-100;% 出力の下限値[kW]
max_pi3c = -10;% 出力の上限値[kW]
Pd_3c = -95;% 需要計画[kW]
Delay_3C = -90.5;% シミュレーション開始時の出力[kW]



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%VPP管理者による価格提示方策%%%%%
%%%価格の初期値設定
persistent lambda;
if isempty(lambda) 
   lambda = -6;
end

deltaP = P1 + P2 + P3 - Ps;
%%P1は施設1の電力出力，P2は施設2の電力出力，P3は施設3の電力出力，PsはVPP運用計画w＾VPP
%%egXの計算%%%
R = 1/2/wF1 + 1/2/wF2 + 1/2/wF3;
egX = 1/gammaX * pi/Tvpp* 1/R;

lambda = lambda + egX*Tvpp*deltaP;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%施設1の管理者による施設運用目標値の決定%%%%%
     if cvx_switch1 == 1
        % ----- cvx -----
        cvx_quiet(true)
        cvx_begin
        variables PrM1
         J = wF1*((PrM1-Pd1)*(PrM1-Pd1)) + (pp1*(PrM1-Pd1));
         minimize( J )
         subject to
          minPrM1 <= PrM1 %#ok<NOPRT>
          PrM1 <=  maxPrM1 %#ok<NOPRT>
        cvx_end
        cvx_quiet(false)
        % ----- cvx -----
        PrM1 = round(PrM1,6);
    else
        % ----- if else -----
        Ptmp = Pd1 - pp1/(2*wF1);
        
        if Ptmp < minPrM1 %%% lower limit
            PrM1 = minPrM1;
        elseif Ptmp > maxPrM1 %%% upper limit
            PrM1 = maxPrM1;
        else %%% interior point
            PrM1 = Ptmp;
        end
        % ----- if else -----
    end
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%施設1の管理者による価格提示方策%%%%%
%%%価格の初期値設定
persistent lambda_1;
if isempty(lambda_1) 
   lambda_1 = -16.8;
end

deltaP_1 = sP1a + sP2a + sP3a - P1;
%%sP1a蓄電機器の電力，sP2a電気自動車の電力，sP3aは工場の負荷整備のデータ,P1は施設運用目標値%%
%%%eg_1の計算%%%%
R_1 = 1/2/w_1s + 1/2/w_1EV;
eg_1 = 1/gamma1 *pi/Ts *1/R_1;

lambda_1 = lambda_1 + eg_1*Ts*deltaP_1;
    
%%%非ワインドアップ化
if     lambda_1 >= upper_price1
       lambda_1 = upper_price1;
elseif lambda_1 <= lower_price1
       lambda_1 = lower_price1;
else
       %lambda_1 = lambda_1;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%施設1の蓄電機器による機器運転目標値の決定%%%%%
% ----- change constraint value caused by soc 
    if soc >= 0.9
        min_pi1c = 0; %minPr = minPr
    elseif (soc < 0.9) && (soc >= 0.88)
        min_pi1c = min_pi1c * ( (0.9-soc)/(0.9-0.88) );
    elseif (soc > 0.1) && (soc <= 0.12)
        max_pi1c = max_pi1c * ( (soc-0.1)/(0.12-0.1) );
    elseif soc <= 0.1
        max_pi1c = 0; %maxPr = maxPr
    else
        %maxPr = maxPr;
        %minPr = minPr;
    end
    % ----- change constraint value caused by soc - method 2
    
    if cvx_switch == 1
        % ----- cvx -----
        cvx_quiet(true)
        cvx_begin
        variables Prk
         J = w_1c*((Prk-Pe)*(Prk-Pe)) + (pe*(Prk-Pe));
         minimize( J )
         subject to
          minPrk <= Prk %#ok<NOPRT>
          Prk <=  max_pi1c %#ok<NOPRT>
        cvx_end
        cvx_quiet(false)
        % ----- cvx -----
    else
        % ----- if else -----
        Pte = Pe - pe/(2*w_1c);
        
        if Pte < min_pi1c %%% lower limit
            Prk = min_pi1c;
        elseif Pte > max_pi1c
            Prk = max_pi1c;
        else
            Prk = Pte;
        end
        % ----- if else -----
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%施設1の電気自動車による機器運転目標値の決定%%%%%
% ----- change constraint value caused by soc
    if soc >= 0.9
        min_pi1EV = 0; %minPr = minPr
    elseif (soc < 0.9) && (soc >= 0.88)
        min_pi1EV = min_pi1EV * ( (0.9-soc)/(0.9-0.88) );
    elseif (soc > 0.1) && (soc <= 0.12)
        max_pi1EV = max_pi1EV * ( (soc-0.1)/(0.12-0.1) );
    elseif soc <= 0.1
        max_pi1EV = 0; %maxPr = maxPr
    else
        %maxPr = maxPr;
        %minPr = minPr;
    end
    % ----- change constraint value caused by soc - method 2
    
    if cvx_switch == 1
        % ----- cvx -----
        cvx_quiet(true)
        cvx_begin
        variables Prk
         J = w_1EV*((Prk-Pe)*(Prk-Pe)) + (pe*(Prk-Pe));
         minimize( J )
         subject to
          minPrk <= Prk %#ok<NOPRT>
          Prk <=  max_pi1EV %#ok<NOPRT>
        cvx_end
        cvx_quiet(false)
        % ----- cvx -----
    else
        % ----- if else -----
        Pte = Pe - pe/(2*w_1EV);
        
        if Pte < min_pi1EV %%% lower limit
            Prk = min_pi1EV;
        elseif Pte > max_pi1EV
            Prk = max_pi1EV;
        else
            Prk = Pte;
        end
        % ----- if else -----
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
