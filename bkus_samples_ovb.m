function [VV,VVc] = bkus_samples_ovb (z1,ncam,vp_ref,vs_ref,rho1,rho2)

vp1(:,1) = vp_ref(:,1);
vp2(:,1) = vp_ref(:,2);
vs1(:,1) = vs_ref(:,1);
vs2(:,1) = vs_ref(:,2);

for i = 1:numel(ncam) % numero de modelos
 
    zz = z1(1:ncam(i));
     
    for j = 1:ncam(i)  % numero de camadas por modelo
        
         if mod(j,2) == 1
             r(j) = rho1(j);
             vp(j)  = vp1(j);
             vs(j)  = vs1(j);            
         else            
             r(j) = rho2(j);
             vp(j) = vp2(j);
             vs(j) = vs2(j); 
         end
    end
    
    F = sum(zz);
    f = zz/F;
    mu=r.*vs.*vs;
    lam=r.*vp.*vp-2*mu;

    x=sum(f.*mu.*(lam+mu)./(lam+2*mu));
    y=sum(f.*mu.*lam./(lam+2*mu));
    z=sum(f.*lam./(lam+2*mu));
    u=sum(f./(lam+2*mu));
    v=sum(f./mu);
    w=sum(f.*mu);

    c11=4*x+z*z/u;
    c12=2*y+z*z/u;
    c33=1/u;
    c13=z/u;
    c44=1/v;
    c66=w;
    c661=(c11-c12)/2;

    if abs(c661-c66)>.1
    disp('There is a problem with the calculation')
    disp('c66 is not equal to (c11-c12)/2')
    pause
    end

    rho=sum(f.*r);

    vpx(i)=sqrt(c11/rho);
    vpz(i)=sqrt(c33/rho);
    vsh(i)=sqrt(c66/rho);
    vsz(i)=sqrt(c44/rho);

    vpx_c(i) = sum(zz.*vp)/sum(zz);  
    vpz_c(i) = 1/( (1./sum(zz)) * sum(zz./vp) );
    vsh_c(i) = sum(zz.*vs)/sum(zz);
    vsz_c(i) = 1/( (1./sum(zz)) * sum(zz./vs) );
    
end

    VV  =[vpx',vpz',vsh',vsz'];
    VVc =[vpx_c',vpz_c',vsh_c',vsz_c'];

end 