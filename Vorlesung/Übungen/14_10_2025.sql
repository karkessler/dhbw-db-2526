DROP TABLE IF EXISTS Vorlesung;

CREATE TABLE Vorlesung
(
    VorlNr INTEGER PRIMARY KEY,
    Titel  VARCHAR(50) NOT NULL,
    SWS    INTEGER NOT NULL
);

INSERT INTO Vorlesung (VorlNr, Titel, SWS)
VALUES (321, 'Analysis', 4);
