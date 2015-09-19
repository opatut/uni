
% endprodukt(Produkt)
% Produkt ist der Name eines fertiggestellten Endproduktes
endprodukt(galaxy2001).
endprodukt(galaxy2002).
endprodukt(galaxy2003).
endprodukt(galaxy2004).

% zulieferung(Produkt)
% Produkt ist der Name einer von einem Zulieferer bezogenen Koponente
zulieferung(box0815).
zulieferung(vxs999).
zulieferung(wumme27).
zulieferung(q23b4).
zulieferung(m17).
zulieferung(m27).
zulieferung(abc1x1).

% arbeitsschritt(Produkt1, Stueckzahl,Arbeitsplatz,Produkt2)
% Produkt1 und Produkt2 sind die Namen von Geraetekomponenten
% und Arbeitsplatz ist der Name eines Fertigungsschritts, so dass
% die durch Stueckzahl angegebene Anzahl von Produkt1 im 
% Fertigungsschritt Arbeitsplatz in Teil2 transformiert wird
arbeitsschritt(box0815,1,stanze,box0816).
arbeitsschritt(box0816,5,vormontage,box0817).
arbeitsschritt(vxs999,8,konfigurator,display).
arbeitsschritt(display,1,vormontage,box0817).
arbeitsschritt(wumme27,1,mobilisator,extra_booster).
arbeitsschritt(q23b4,4,mobilisator,extra_booster).
arbeitsschritt(wumme27,1,ultra_mobilisator,ultra_booster).
arbeitsschritt(q23b4,8,ultra_mobilisator,ultra_booster).
arbeitsschritt(m17,13,traumatisator,twister).
arbeitsschritt(abc1x1,1,traumatisator,twister).
arbeitsschritt(abc1x1,1,tranquilisator,neutralisator).
arbeitsschritt(m27,9,tranquilisator,neutralisator).
arbeitsschritt(extra_booster,1,grobtuner,squeezer).
arbeitsschritt(twister,1,grobtuner,squeezer).
arbeitsschritt(extra_booster,1,feintuner,back_squeezer).
arbeitsschritt(twister,1,feintuner,back_squeezer).
arbeitsschritt(ultra_booster,2,kompostierer,zero_squeezer).
arbeitsschritt(neutralisator,2,kompostierer,zero_squeezer).
arbeitsschritt(ultra_booster,2,dekompostierer,hyper_squeezer).
arbeitsschritt(neutralisator,2,dekompostierer,hyper_squeezer).
arbeitsschritt(box0817,1,montage1,galaxy2001).
arbeitsschritt(zero_squeezer,3,montage1,galaxy2001).
arbeitsschritt(box0817,1,montage1,galaxy2002).
arbeitsschritt(back_squeezer,2,montage1,galaxy2002).
arbeitsschritt(squeezer,1,konversion,k_squeezer).
arbeitsschritt(box0817,1,montage2,galaxy2003).
arbeitsschritt(k_squeezer,2,montage2,galaxy2003).
arbeitsschritt(box0817,1,montage3,galaxy2004).
arbeitsschritt(k_squeezer,2,montage3,galaxy2004).
arbeitsschritt(hyper_squeezer,4,montage3,galaxy2004).

