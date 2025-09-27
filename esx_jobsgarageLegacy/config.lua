Config = {}

Config.Garages = {

    police = {
        cars = {
            {
                label = "PSP Carros",
                job = "police",
                coords = vector3(458.6, -1010.5, 27.3),
                spawns = { -- vários pontos de spawn
                    vector4(442.5, -1025.1, 28.7, 4.6),
                    vector4(438.9, -1025.5, 28.8, 13.0),
                    vector4(435.3, -1026.1, 28.8, 5.8)
                },
                returnCoords = vector3(454.9, -1019.6, 28.3),
                markerColor = {0,0,255},
                markerSize = 3.0,

                ped = {
                    model = "ig_trafficwarden", -- modelo do ped
                    coords = vector4(458.6, -1010.5, 27.3, 100.0) -- posição e heading do NPC
                },

                vehicles = {
                    {model='psp_1300', label='Mota', minGrade=0},
                    {model='tempra_psp', label='Tempra', minGrade=0},
                    {model='psp_skodapp', label='Skoda 00', minGrade=1},
                    {model='psp_skoda09', label='Skoda 01', minGrade=1},
                    {model='cliopsp', label='Clio', minGrade=1},
                    {model='psp_octavia', label='Octavia 00', minGrade=2},
                    {model='psp_octavia2', label='Octavia 01', minGrade=2},
                    {model='skoda2psp', label='Skoda 02', minGrade=2},
                    {model='psp_ftipo', label='Tipo', minGrade=3},
                    {model='psp_subaru', label='Empresa', minGrade=3},
                    {model='psp_corolla', label='Corolla', minGrade=3},
                    {model='psp_bmwf30', label='F30', minGrade=3},
                    {model='x6psp', label='X6', minGrade=4},
                    {model='psp_i8', label='I8', minGrade=4},
                    {model='psp_r8', label='R8', minGrade=4},
                    {model='psp_sharan', label='PSP Sharan', minGrade=2},
                    {model='nddrs6v2', label='RS6', minGrade=4},
                    {model='mustangpsp', label='Mustang', minGrade=4},
                    {model='dgrsp_vwcrafter', label='Carrinha Presos', minGrade=1},
                    {model='23s63', label='Amg Descaracterizado', minGrade=1},
                    {model='ndd530', label='530 Descaracterizado', minGrade=1},
                    {model='psp_a4', label='A4 Descaracterizado', minGrade=1},
                    {model='seatleon', label='Leon Judiciária', minGrade=1},
                    {model='psp_mbsprinter', label='UEP Sprinter 01', minGrade=1},
                    {model='uep_berlingo', label='UEP Berlingo', minGrade=1},
                    {model='uep_sharan', label='UEP Sharan', minGrade=1},
                    {model='uep_sprinter', label='UEP Sprinter 02', minGrade=1}
                }
            }
        },
        heli = {
            {
                label = "PSP Helicópteros",
                job = "police",
                coords = vector3(449.2, -981.53, 43.69),
                spawn = vector4(449.2, -981.53, 43.69, 175.68),
                returnCoords = vector3(449.3, -981.3, 43.7),
                markerColor = {0,0,255},
                markerSize = 3.0,

                ped = {
                    model = "ig_trafficwarden", -- modelo do ped
                    coords = vector4(461.2, -981.0, 42.7, 180.0) -- posição e heading do NPC
                },

                vehicles = {
                    {model='swift', label='Heli 01', minGrade=2},
                    {model='koala', label='Heli 02', minGrade=4}
                }
            }
        },
        boats = {
            {
                label = "PSP Barcos",
                job = "police",
                coords = vector3(-793.05, -1491.87, 1.6),
                spawn = vector4(-794.17, -1501.56, -0.47, 109.7),
                returnCoords = vector3(-796.02, -1502.59, 1.6),
                returnPlayer = vector4(-799.85, -1494.12, 1.6, 122.68),
                markerColor = {0,0,255},
                markerSize = 3.0,

                ped = {
                    model = "ig_trafficwarden", -- modelo do ped
                    coords = vector4(-793.1, -1491.8, 0.6, 200.0) -- posição e heading do NPC
                },

                vehicles = {
                    {model='safe33', label='Barco', minGrade=1}
                }
            }
        }
    },

    ambulance = {
        cars = {
            {
                label = "INEM Carros",
                job = "ambulance",
                coords = vector3(294.2, -598.0, 42.3),
                spawns = { -- vários pontos de spawn
                    vector4(297.573, -601.859, 43.012, 68.031),
                    vector4(296.096, -604.430, 43.029, 68.031),
                    vector4(294.962, -607.186, 43.046, 68.031),
                    vector4(293.947, -609.942, 43.046, 68.031)
                },
                returnCoords = vector3(290.63, -572.79, 43.18),
                markerColor = {255,0,255},
                markerSize = 3.0,


                ped = {
                    model = "ig_trafficwarden", -- modelo do ped
                    coords = vector4(294.2, -598.0, 42.3, 72.0) -- posição e heading do NPC
                },
            
                vehicles = {
                    {model='motobm', label='Mota 01', minGrade=0},
                    {model='inem_tracer', label='Mota 02', minGrade=0},
                    {model='emir_vwgolf6', label='VW 6', minGrade=0},
                    {model='ambulancei', label='Passat', minGrade=0},
                    {model='INEM_AEM', label='Ambulancia', minGrade=0},
                    {model='vmer_skoda18', label='Octavia Médico', minGrade=0},
                    {model='vmer4', label='Modeo Médico', minGrade=0},
                    {model='vmer_skoda21', label='Octavia INEM', minGrade=0},
                    {model='pt_inem4', label='SIV', minGrade=3}
                }
            }
        },
        heli = {
            {
                label = "INEM Helicópteros",
                job = "ambulance",
                coords = vector3(351.86, -587.95, 74.06),
                spawn = vector4(351.86, -587.95, 74.06, 249.18),
                returnCoords = vector3(351.5, -588.1, 74.2),
                markerColor = {255,0,255},
                markerSize = 5.0,

                ped = {
                    model = "ig_trafficwarden", -- modelo do ped
                    coords = vector4(337.7, -586.6, 73.2, 247.7) -- posição e heading do NPC
                },

                vehicles = {
                    {model='aw139', label='I-RAKE', minGrade=2},
                    {model='inem1', label='EC-HFD', minGrade=2},
                    {model='inem2', label='CS-AYN', minGrade=2}
                }
            }
        },
        boats = {
            {
                label = "INEM Barcos",
                job = "ambulance",
                coords = vector3(-793.05, -1491.87, 1.6),
                spawn = vector4(-794.17, -1501.56, -0.47, 109.7),
                returnCoords = vector3(-796.02, -1502.59, 1.0),
                returnPlayer = vector4(-799.85, -1494.12, 1.6, 122.68),
                markerColor = {255,0,255},
                markerSize = 3.0,

                ped = {
                    model = "ig_trafficwarden", -- modelo do ped
                    coords = vector4(-793.1, -1491.8, 0.6, 200.0) -- posição e heading do NPC
                },

                vehicles = {
                    {model='dinghy', label='Barco', minGrade=1}
                }
            }
        }
    },

    firefighter = {
        cars = {
            {
                label = "Bombeiros Carros",
                job = "firefighter",
                coords = vector3(1212.58, -1474.7, 34.69),
                spawns = { -- vários pontos de spawn
                    vector4(1213.8, -1460.4, 35.2, 360.0),
                    vector4(1209.8, -1460.1, 35.3, 360.0),
                    vector4(1205.5, -1460.2, 35.3, 360.0),
                    vector4(1199.6, -1460.2, 34.8, 360.0)
                },
                returnCoords = vector3(1178.2, -1518.1, 34.7),
                markerColor = {255,165,0},
                markerSize = 3.0,
                ped = {
                    model = "s_m_y_fireman_01", -- modelo do ped
                    coords = vector4(1217.894, -1477.701, 33.688, 85.688) -- posição e heading do NPC
                },
                vehicles = {
                    {model='bv_absc01', label='ABSC01', minGrade=0},
                    {model='bv_absc02', label='ABSC02', minGrade=0},
                    {model='bv_absc03', label='ABSC03', minGrade=0},
                    {model='bv_absc04', label='ABSC04', minGrade=0},
                    {model='bv_Crafter', label='ABSC05', minGrade=1},
                    {model='bv_CrafterInem', label='ABSC06', minGrade=1},
                    {model='bv_patrol', label='VCOT01', minGrade=1},
                    {model='bv_patrol1', label='VTTP01', minGrade=1},
                    {model='bv_raptovpa', label='RAM VCOT01', minGrade=2},
                    {model='bv_vcot_02', label='VCOT02', minGrade=2},
                    {model='bv_unimog2', label='UNIMOG VFCI01', minGrade=2},
                    {model='bv_vfci_tugafire', label='VFCI', minGrade=2},
                    {model='bv_vpma', label='VPMA01', minGrade=3},
                    {model='bv_vsae_loule', label='VSAE01', minGrade=3},
                    {model='bv_vsat_01', label='VSAT01', minGrade=3},
                    {model='bv_vttf_02', label='VTTF02', minGrade=3},
                    {model='bv_vuci_01', label='VUCI01', minGrade=3},
                    {model='bv_vcoc01', label='VCOC01', minGrade=4},
                    {model='bv_vlci_03', label='VLCI03', minGrade=4},
                    {model='bv_vlci_navarra', label='VLCI02', minGrade=4},
                    {model='bv_vope_01', label='VOPE02', minGrade=4},
                    {model='bv_vale_01', label='VALE02', minGrade=4}
                }
            }
        },
        heli = {
            {
                label = "Bombeiros Helicópteros",
                job = "fire",
                coords = vector3(1220.92, -1512.53, 36.35),
                spawn = vector4(1221.87, -1512.46, 36.35, 90.49),
                returnCoords = vector3(1221.059, -1512.395, 36.339),
                markerColor = {255,165,0},
                markerSize = 5.0,
                ped = {
                    model = "s_m_y_fireman_01", -- modelo do ped
                    coords = vector4(1218.725, -1495.885, 33.840, 96.377) -- posição e heading do NPC
                },
                vehicles = {
                    {model='heli01', label='EC-MEJ', minGrade=2},
                    {model='heli02', label='CS-HMI', minGrade=2},
                    {model='anpc_kamov', label='KAMOC', minGrade=3},
                    {model='firehawk', label='FIREHWAK', minGrade=4}
                }
            }
        },
        boats = {
            {
                label = "Bombeiros Barcos",
                job = "fire",
                coords = vector3(-793.05, -1491.87, 1.6),
                spawn = vector4(-794.17, -1501.56, -0.47, 109.7),
                returnCoords = vector3(-793.64, -1502.12, 1.12),
                returnPlayer = vector4(-799.85, -1494.12, 1.6, 122.68),
                markerColor = {255,165,0},
                markerSize = 3.0,

                ped = {
                    model = "s_m_y_fireman_01", -- modelo do ped
                    coords = vector4(-793.1, -1491.8, 0.6, 200.0) -- posição e heading do NPC
                },

                vehicles = {
                    {model='dinghy', label='Barco 01', minGrade=1},
                    {model='safe33f', label='Barco 02', minGrade=3}
                }
            }
        }
    },

    lifeguard = {
        cars = {
            {
                label = "Nadador Salvador Carros",
                job = "lifeguard",
                coords = vector3(-1492.5, -1019.9, 6.3),
                spawns = { -- vários pontos de spawn
                    vector4(-1487.5, -1018.2, 5.9, 318.8)
                },
                returnCoords = vector3(-1481.8, -1002.7, 6.3),
                markerColor = {255,0,255},
                markerSize = 3.0,


                ped = {
                    model = "ig_trafficwarden", -- modelo do ped
                    coords = vector4(-1492.5, -1019.9, 5.3, 237.2) -- posição e heading do NPC
                },
            
                vehicles = {
                    {model='bv_gwquad', label='Mota', minGrade=0},
                    {model='ltundra', label='Carrinha', minGrade=0}             
                }
            }
        }
    },

}
