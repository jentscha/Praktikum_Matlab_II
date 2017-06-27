function [  ] = animierePendel( vT, mX, stPendel, hAxes, varargin )

MakeAvi = false;
if nargin == 5
    MakeAvi = varargin{1};
end

Tpause = 1/25;


vTAnim = 0:Tpause:vT(end);
mXAnim = interp1(vT,mX,vTAnim);

nBilder = length(mXAnim);

if isempty(hAxes)
    figure;
    hAxes = axes();
end
axis([-2 2 -2 2]*0.2)

hold on;
for i = 1:nBilder
    if i>1
        delete(hPendel);
    end
    P1 = [sin(mXAnim(i,1)), -cos(mXAnim(i,1))]*0.2;
    P2 = P1 + [sin(mXAnim(i,3)), -cos(mXAnim(i,3))]*0.2;
    hPendel = plot(hAxes, [0, P1(1)],[0, P1(2)],'b',...
                    [P1(1), P2(1)], [P1(2), P2(2)],'r');
    title(['t = ',num2str(vTAnim(i)),' sec']);
    xlabel('x[m]');
    ylabel('y[m]');
    
    if MakeAvi
        if i == 1
            vFrames = getframe(hAxes);
        end
        vFrames(end+1) = getframe(hAxes);
    end
    
    pause(Tpause);
end
hold off;

if MakeAvi
    v = VideoWriter('animation.avi','Uncompressed AVI');
    open(v)
    writeVideo(v,vFrames);
end
end

