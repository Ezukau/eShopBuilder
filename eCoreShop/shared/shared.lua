Config = {}

Config = {

    ShopItem = {

        {
            Banner = "img_red", -- Banniere
            Directory = "root_cause5", -- Fichier ou se trouve labanniere

            NameMenu = "Epicerie", -- Nom du menu
            DescriptionMenu = "Interaction",
            ColorMenu = "r", -- Couleur du menu

            PositonMenu = {
                vector3(214.9206, -922.072, 60.70964) -- Position du Menu
            }, 

            PedEnable = true, 
            Ped = {
                pos = vector4(214.9206, -922.072, 60.70964, 180.0), -- Position du Ped
                hash = "a_f_m_beach_01",
            },

            BlipsEnable = true,
            Blips = {
                Id = 59,
                Color = 2,
                Taille = 0.7,
                Range = true,
                Name = "Epicerie",
                pos = vector3(214.9206, -922.072, 60.70964)
            },

            MarkesEnable = true,
            Marker = {
                Type = 23,
                ColorR = 255,
                ColorG = 0,
                ColorB = 0,
                Opacite = 200, 
                SizeLargeur = 0.3,
                SizeEpaisseur = 0.3,
                SizeHauteur = 0.3,
                Saute = false, 
                Tourne = false,
                Distance = 20.0,
            },

            Items = { -- Liste des items achetable
                {label = "Pain", name = "bread", price = 5, qtmax = 10, ListIndex = 1, donttouch = {}},
                {label = "Eau", name = "water", price = 10, qtmax = 5, ListIndex = 1, donttouch = {}},

            },

            PayedMethode = {
                Cash = true, -- Liquide
                Bank = true, -- Banque
                BlackMoney = false -- Argent Sale
            },

        },

    },
}



