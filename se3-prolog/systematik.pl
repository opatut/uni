% reich(Name)
% sub(Unterkategorie,Gliederungsebene_der_Unterkategorie,naechsthoehere_Oberkategorie)

reich(vielzeller).
  sub(schwaemme,stamm,vielzeller).
    sub(kalkschwaemme,klasse,schwaemme).
  sub(gliederfuesser,stamm,vielzeller).
    sub(insekten,klasse,gliederfuesser).
      sub(kaefer,ordnung,insekten).
      sub(schmetterlinge,ordnung,insekten).
      sub(floehe,ordnung,insekten).
        sub(pulicidae,familie,floehe).
          sub(pulex, gattung, pulicidae).
          sub(ctenocephalides, gattung, pulicidae).
            sub(menschenfloh,art,pulex).
            sub(hundefloh,art,ctenocephalides).
    sub(spinnentiere,klasse,gliederfuesser).
  sub(chordatiere,stamm,vielzeller).
    sub(saeugetiere,klasse,chordatiere).
      sub(beutelratten,ordnung,saeugetiere).
      sub(nagetiere,ordnung,saeugetiere).
      sub(raubtiere,ordnung,saeugetiere). 
        sub(baeren,familie,raubtiere).
        sub(hunde,familie,raubtiere).
        sub(katzen,familie,raubtiere).
     sub(primaten,ordnung,saeugetiere).
        sub(meerkatzenartige,familie,primaten). 
        sub(gibbons,familie,primaten). 
        sub(menschenaffen,familie,primaten). 
          sub(menschen,gattung,menschenaffen).
          sub(orang_utans,gattung,menschenaffen).
          sub(schimpansen,gattung,menschenaffen).
            sub(gemeiner_schimpanse,art,schimpansen).
            sub(bonobo,art,schimpansen).
          sub(gorillas,gattung,menschenaffen).
            sub(mensch,art,menschen).
    sub(reptilien,klasse,chordatiere).
      sub(schlangen,ordnung,reptilien).
        sub(vipern,familie,schlangen).
        sub(nattern,familie,schlangen).
        sub(riesenschlangen,familie,schlangen).
    sub(voegel,klasse,chordatiere).
      sub(schreitvoegel,ordnung,voegel).
        sub(stoerche,familie,schreitvoegel).
        sub(reiher,familie,schreitvoegel).
      sub(singvoegel,ordnung,voegel).
        sub(stare,familie,singvoegel).
        sub(drosseln,familie,singvoegel).
      sub(spechtvoegel,ordnung,voegel).
        sub(spechte,familie,spechtvoegel).
          sub(buntspechte,gattung,spechte).
            sub(buntspecht,art,buntspechte).
            sub(kleinspecht,art,buntspechte).
            sub(mittelspecht,art,buntspechte).
          sub(schluckspechte,gattung,spechte). 
          sub(schwarzspechte,gattung,spechte).
            sub(schwarzspecht,art,schwarzspechte).
  sub(armfuesser,stamm,vielzeller).
  sub(weichtiere,stamm,vielzeller).
    sub(schnecken,klasse,weichtiere).
    sub(muscheln,klasse,weichtiere).

reich(bakterien).
reich(viren).
reich(pflanzen).
  sub(laubmoose,abteilung,pflanzen).
  sub(gefaesspflanzen,abteilung,pflanzen).
    sub(farne,klasse,gefaesspflanzen).
    sub(koniferen,klasse,gefaesspflanzen).
    sub(bedecktsamer,klasse,gefaesspflanzen).
reich(pilze).

