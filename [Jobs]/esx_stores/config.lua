Config = {}

Config.webhook = "https://discord.com/api/webhooks/1054975744570310686/OjJ6WWMsqepeFEmjeAPJvizhHk5yOByds5gXFitkZybHjKgj6rhlV3vtcTY8TeZhqNyC"						-- Webhook to send logs to discord
Config.lang = "de"								-- Set the file language [en/br/de]

Config.ESX = {									-- ESX settings
	['ESXSHAREDOBJECT'] = "esx:getSharedObject",-- Change your getshared object event here, in case you are using anti-cheat
	['esx_version'] = '1.0',					-- Change your ESX version here [Set 1.1 if you use limit / Set 1.2 if you use weight/ Set custom to use a custom one, see server_utils.lua]
}

Config.debug_config = false						-- Use this as true when you remove or change any item in the config, this will clear database dependency errors. Set to false after running the script once

Config.format = {
	['currency'] = 'USD',						-- This is the currency format, so that your currency symbol appears correctly [Examples: BRL, USD] (https://taxsummaries.pwc.com/glossary/currency-codes)
	['location'] = 'de-DE'						-- This is the location of your country, to format the decimal places according to your standard [Examples: pt-BR, en-US] (http://www.lingoes.net/en/translator/langcode.htm)
}

Config.max_stores_per_player = 1				-- Maximum number of stores that each player can have
Config.has_stock_when_unowed = true				-- If true, the store stock will be full stock when there is no owner. If false, the store stock will be empty when there is no owner
Config.max_jobs = 20							-- Max amount of jobs that each store can create
Config.trucker_logistics = {					-- Settings related to the link with the Truck Logistics script
	['enable'] = false,							-- Set this as true if you own the Truck Logistics script and want to link the jobs created in the Hire Deliveryman page with the truckers ()
	['available_trucks'] = {					-- List of trucks that are generated in contracts
		"actros","man","daf","man"
	},
	['available_trailers'] = {					-- List of trailers that are generated in contracts
		"trailers", "trailers2", "trailers3"
	}
}

-- Here are the places where the person can open the market menu
-- You can add as many locations as you want, just use the location already created as an example
Config.market_locations = {
	["market_1"] = {															-- ID
		['buy_price'] = 4000000,													-- Price to buy this market
		['sell_price'] = 3000000,												-- Price to sell this market
		['coord'] = {-709.57440185547,-905.78985595703,19.215585708618},		-- Coordinate to open the menu
		['garage_coord'] = {-707.13,-924.98,19.02,179.01},						-- Garage coordinates, where the trucks will spawn (coordinates composed of x, y, z, h)
		['truck_parking_location'] = {-707.95, -929.8, 19.01, 180.0},			-- Location that the trucks from Trucker Logistics script will park when delivering cargo for this store
		['sell_blip_coords'] = {												-- The coordinates where customes will buy things on this store (coordinates composed of x, y, z)
			{-707.696716, -914.545044, 19.203613}
		},
		['deliveryman_coord'] = {-714.55,-917.8,19.22},							-- Coord where the deliveryman will take the jobs you've created
		['type'] = '247store', 													-- Insert here the market type ID
		['account'] = {															-- Account settings for this store
			['item'] = {														-- Account that the money should be debited when buying item in the market (player can choose between 2)
				[1] = {
					['icon'] = 'img/credit_card.png',
					['account'] = 'bank'
				},
				[2] = {
					['icon'] = 'img/cash.png',
					['account'] = 'cash'
				}
			},
			['store'] = 'bank',													-- Account that should be used with store expenses (owner)
		}
	},
	["market_2"] = {
		['buy_price'] = 4000000,
		['sell_price'] = 3000000,
		['coord'] = {30.239591598511,-1339.2818603516,29.497043609619},
		['garage_coord'] = {15.3,-1345.17,29.29,179.17},
		['truck_parking_location'] = {24.0538,-1357.3694, 29.503,88.4017},
		['sell_blip_coords'] = {
			{25.711700439453,-1346.4722900391,29.497022628784}
		},
		['deliveryman_coord'] = {22.906536102295,-1350.3334960938,29.327049255371},
		['type'] = '247store',
		['account'] = {
			['item'] = {
				[1] = {
					['icon'] = 'img/credit_card.png',
					['account'] = 'bank'
				},
				[2] = {
					['icon'] = 'img/cash.png',
					['account'] = 'cash'
				}
			},
			['store'] = 'bank',
		}
	},
	["market_3"] = {
		['buy_price'] = 4000000,
		['sell_price'] = 3000000,
		['coord'] = {2549.6564941406,386.92138671875,108.62294006348},
		['garage_coord'] = {2588.82,413.31,108.46,178.94},
		['truck_parking_location'] = {2564.896,366.3779, 108.7248,177.4842},
		['sell_blip_coords'] = {
			{2556.7326660156,382.11276245117,108.62294006348}
		},
		['deliveryman_coord'] = {2560.1857910156,382.88265991211,108.62112426758},
		['type'] = '247store',
		['account'] = {
			['item'] = {
				[1] = {
					['icon'] = 'img/credit_card.png',
					['account'] = 'bank'
				},
				[2] = {
					['icon'] = 'img/cash.png',
					['account'] = 'cash'
				}
			},
			['store'] = 'bank',
		}
	},
	["market_4"] = {
		['buy_price'] = 4000000,
		['sell_price'] = 3000000,
		['coord'] = {1159.861328125,-315.43588256836,69.205146789551},
		['garage_coord'] = {1155.32,-336.2,68.35,188.49},
		['truck_parking_location'] = {1184.322,-314.0848, 69.4398,279.8044},
		['sell_blip_coords'] = {
			{1163.4259033203,-322.91970825195,69.205146789551}
		},
		['deliveryman_coord'] = {1154.8171386719,-326.7705078125,69.205146789551},
		['type'] = '247store',
		['account'] = {
			['item'] = {
				[1] = {
					['icon'] = 'img/credit_card.png',
					['account'] = 'bank'
				},
				[2] = {
					['icon'] = 'img/cash.png',
					['account'] = 'cash'
				}
			},
			['store'] = 'bank',
		}
	},
	["market_5"] = {
		['buy_price'] = 4000000,
		['sell_price'] = 3000000,
		['coord'] = {-1827.9733886719,798.20367431641,138.17694091797},
		['garage_coord'] = {-1821.48,777.52,137.43,216.69},
		['truck_parking_location'] = {-1807.3877,789.4099, 138.4138,220.8947},
		['sell_blip_coords'] = {
			{-1820.92578125,793.17431640625,138.11315917969}
		},
		['deliveryman_coord'] = {-1826.259765625,785.52191162109,138.28074645996},
		['type'] = '247store',
		['account'] = {
			['item'] = {
				[1] = {
					['icon'] = 'img/credit_card.png',
					['account'] = 'bank'
				},
				[2] = {
					['icon'] = 'img/cash.png',
					['account'] = 'cash'
				}
			},
			['store'] = 'bank',
		}
	},
	["market_6"] = {
		['buy_price'] = 4000000,
		['sell_price'] = 3000000,
		['coord'] = {380.2028503418,332.70526123047,103.56661224365},
		['garage_coord'] = {366.43,332.03,103.51,165.15},
		['truck_parking_location'] = {361.3589,319.2109, 103.9061,76.4428},
		['sell_blip_coords'] = {
			{374.2092590332,326.91537475586,103.56636810303}
		},
		['deliveryman_coord'] = {379.77386474609,324.36444091797,103.56636810303},
		['type'] = '247store',
		['account'] = {
			['item'] = {
				[1] = {
					['icon'] = 'img/credit_card.png',
					['account'] = 'bank'
				},
				[2] = {
					['icon'] = 'img/cash.png',
					['account'] = 'cash'
				}
			},
			['store'] = 'bank',
		}
	},
	["market_7"] = {
		['buy_price'] = 4000000,
		['sell_price'] = 3000000,
		['coord'] = {-3249.6938476563,1006.4963378906,12.830717086792},
		['garage_coord'] = {-3243.39,991.74,12.48,272.72},
		['truck_parking_location'] = {-3234.5576,1009.0838, 12.4311,177.7641},
		['sell_blip_coords'] = {
			{-3242.9636230469,1001.3184204102,12.830706596375}
		},
		['deliveryman_coord'] = {-3240.6967773438,1007.2897338867,12.830706596375},
		['type'] = '247store',
		['account'] = {
			['item'] = {
				[1] = {
					['icon'] = 'img/credit_card.png',
					['account'] = 'bank'
				},
				[2] = {
					['icon'] = 'img/cash.png',
					['account'] = 'cash'
				}
			},
			['store'] = 'bank',
		}
	},
	["market_8"] = {
		['buy_price'] = 4000000,
		['sell_price'] = 3000000,
		['coord'] = {1736.3872070312,6419.7211914062,35.037223815918},
		['garage_coord'] = {1718.27,6418.38,33.45,152.26},
		['truck_parking_location'] = {1713.1648,6410.5093, 33.6366,155.0778},
		['sell_blip_coords'] = {
			{1729.3813476563,6415.4287109375,35.037223815918}
		},
		['deliveryman_coord'] = {1734.0440673828,6411.107421875,35.037223815918},
		['type'] = '247store',
		['account'] = {
			['item'] = {
				[1] = {
					['icon'] = 'img/credit_card.png',
					['account'] = 'bank'
				},
				[2] = {
					['icon'] = 'img/cash.png',
					['account'] = 'cash'
				}
			},
			['store'] = 'bank',
		}
	},
	["market_9"] = {
		['buy_price'] = 4000000,
		['sell_price'] = 3000000,
		['coord'] = {544.38342285156,2662.8591308594,42.15648651123},
		['garage_coord'] = {533.9,2667.9,42.28,8.76},
		['truck_parking_location'] = {533.3693,2669.5442, 42.5447,7.0399},
		['sell_blip_coords'] = {
			{547.74603271484,2671.5610351563,42.156494140625}
		},
		['deliveryman_coord'] = {541.56079101563,2674.0302734375,42.173282623291},
		['type'] = '247store',
		['account'] = {
			['item'] = {
				[1] = {
					['icon'] = 'img/credit_card.png',
					['account'] = 'bank'
				},
				[2] = {
					['icon'] = 'img/cash.png',
					['account'] = 'cash'
				}
			},
			['store'] = 'bank',
		}
	},
	["market_10"] = {
		['buy_price'] = 4000000,
		['sell_price'] = 3000000,
		['coord'] = {1961.1793212891,3749.8298339844,32.343872070313},
		['garage_coord'] = {1972.04,3746.88,32.32,209.52},
		['truck_parking_location'] = {1696.6696,3742.3357, 34.1548,225.9438},
		['sell_blip_coords'] = {
			{1961.3522949219,3741.4907226563,32.343746185303}
		},
		['deliveryman_coord'] = {1966.9969482422,3742.9167480469,32.343742370605},
		['type'] = '247store',
		['account'] = {
			['item'] = {
				[1] = {
					['icon'] = 'img/credit_card.png',
					['account'] = 'bank'
				},
				[2] = {
					['icon'] = 'img/cash.png',
					['account'] = 'cash'
				}
			},
			['store'] = 'bank',
		}
	},
	["market_11"] = {
		['buy_price'] = 4000000,
		['sell_price'] = 3000000,
		['coord'] = {2673.9375,3288.3955078125,55.241134643555},
		['garage_coord'] = {2689.24,3272.53,55.25,328.87},
		['truck_parking_location'] = {2651.1384,3263.427, 55.4719,151.0635},
		['sell_blip_coords'] = {
			{2677.476807, 3281.182373, 55.228516}
		},
		['deliveryman_coord'] = {2679.7431640625,3276.6286621094,55.408432006836},
		['type'] = '247store',
		['account'] = {
			['item'] = {
				[1] = {
					['icon'] = 'img/credit_card.png',
					['account'] = 'bank'
				},
				[2] = {
					['icon'] = 'img/cash.png',
					['account'] = 'cash'
				}
			},
			['store'] = 'bank',
		}
	},
	["market_12"] = {
		['buy_price'] = 4000000,
		['sell_price'] = 3000000,
		['coord'] = {1706.8068847656,4921.125,42.063636779785},
		['garage_coord'] = {1689.02,4919.69,42.08,57.01},
		['truck_parking_location'] = {1686.8475,4922.3828, 42.3414,55.4782},
		['sell_blip_coords'] = {
			{1698.342896, 4924.628418, 42.052002}
		},
		['deliveryman_coord'] = {1700.3133544922,4932.724609375,42.078147888184},
		['type'] = '247store',
		['account'] = {
			['item'] = {
				[1] = {
					['icon'] = 'img/credit_card.png',
					['account'] = 'bank'
				},
				[2] = {
					['icon'] = 'img/cash.png',
					['account'] = 'cash'
				}
			},
			['store'] = 'bank',
		}
	},
	["market_13"] = {
		['buy_price'] = 4000000,
		['sell_price'] = 3000000,
		['coord'] = {-44.314395904541,-1749.6755371094,29.42099571228},
		['garage_coord'] = {-63.1,-1742.7,29.31,57.2},
		['truck_parking_location'] = {-20.8732,-1767.8015, 29.4571,231.7498},
		['sell_blip_coords'] = {
			{-48.672527, -1757.538452, 29.414673}
		},
		['deliveryman_coord'] = {-55.720436096191,-1755.5327148438,29.439630508423},
		['type'] = '247store',
		['account'] = {
			['item'] = {
				[1] = {
					['icon'] = 'img/credit_card.png',
					['account'] = 'bank'
				},
				[2] = {
					['icon'] = 'img/cash.png',
					['account'] = 'cash'
				}
			},
			['store'] = 'bank',
		}
	},
	["market_14"] = {
		['buy_price'] = 4000000,
		['sell_price'] = 3000000,
		['coord'] = {1395.455078125,3607.1713867188,34.98091506958},
		['garage_coord'] = {1384.52,3593.7,34.9,210.34},
		['truck_parking_location'] = {1381.198,3594.0959, 35.1478,200.0481},
		['sell_blip_coords'] = {
			{1392.145020, 3604.510010, 34.975098}
		},
		['deliveryman_coord'] = {1391.8991699219,3598.4467773438,35.031749725342},
		['type'] = '247store',
		['account'] = {
			['item'] = {
				[1] = {
					['icon'] = 'img/credit_card.png',
					['account'] = 'bank'
				},
				[2] = {
					['icon'] = 'img/cash.png',
					['account'] = 'cash'
				}
			},
			['store'] = 'bank',
		}
	},
	["market_15"] = {
		['buy_price'] = 4000000,
		['sell_price'] = 3000000,
		['coord'] = {-3048.3173828125,587.68206787109,7.9091401100159},
		['garage_coord'] = {-3045.94,598.67,7.49,287.24},
		['truck_parking_location'] = {-3032.1746,594.4594, 7.9666,18.8748},
		['sell_blip_coords'] = {
			{-3040.641846, 585.639587, 7.897461, 201.259842}
		},
		['deliveryman_coord'] = {-3038.2590332031,593.58917236328,7.8191342353821},
		['type'] = '247store',
		['account'] = {
			['item'] = {
				[1] = {
					['icon'] = 'img/credit_card.png',
					['account'] = 'bank'
				},
				[2] = {
					['icon'] = 'img/cash.png',
					['account'] = 'cash'
				}
			},
			['store'] = 'bank',
		}
	},
	["market_16"] = {
		['buy_price'] = 4000000,
		['sell_price'] = 3000000,
		['coord'] = {1167.626343, 2719.226318, 37.148682},
		['garage_coord'] = {1169.43,2694.08,37.84,85.41},
		['truck_parking_location'] = {1181.8191,2695.3115, 38.2108,268.9558},
		['sell_blip_coords'] = {
			{1166.518677, 2709.151611, 38.142822}
		},
		['deliveryman_coord'] = {1160.2208251953,2702.11328125,38.183746337891},
		['type'] = '247store',
		['account'] = {
			['item'] = {
				[1] = {
					['icon'] = 'img/credit_card.png',
					['account'] = 'bank'
				},
				[2] = {
					['icon'] = 'img/cash.png',
					['account'] = 'cash'
				}
			},
			['store'] = 'bank',
		}
	},
-- [[	["market_17"] = {
--		['buy_price'] = 70000,
--		['sell_price'] = 35000,
--		['coord'] = {-669.7861328125,5833.7553710938,17.331426620483},
--		['garage_coord'] = {-665.9,5825.51,17.34,96.71},
--		['truck_parking_location'] = {-676.9509,5825.9419, 17.5887,68.3468},
--		['sell_blip_coords'] = {
--			{-677.68890380859,5839.1801757813,17.331409454346},
--			{-676.69445800781,5837.3159179688,17.331407546997},
--		},
--		['deliveryman_coord'] = {-678.53436279297,5833.05859375,17.331130981445},
--		['type'] = '247store',
--		['account'] = {
--			['item'] = {
--				[1] = {
--					['icon'] = 'img/credit_card.png',
--					['account'] = 'bank'
--				},
--				[2] = {
--					['icon'] = 'img/cash.png',
--					['account'] = 'cash'
--				}
--			},
--			['store'] = 'bank',
--		}
--	}, --]]
--	["market_18"] = {
--		['buy_price'] = 70000,
--		['sell_price'] = 35000,
--		['coord'] = {169.27001953125,6644.1645507813,31.71063041687},
--		['garage_coord'] = {146.9,6634.98,31.61,175.81},
--		['truck_parking_location'] = {164.0575,6625.502, 32.0364,225.7734},
--		['sell_blip_coords'] = {
--			{164.15994262695,6641.15625,31.710638046265},
--			{167.01026916504,6637.4892578125,31.710649490356},
--		},
--		['deliveryman_coord'] = {157.05537414551,6641.224609375,31.605260848999},
--		['type'] = '247store',
--		['account'] = {
--			['item'] = {
--				[1] = {
--					['icon'] = 'img/credit_card.png',
--					['account'] = 'bank'
--				},
--				[2] = {
--					['icon'] = 'img/cash.png',
--					['account'] = 'cash'
--				}
--			},
--			['store'] = 'bank',
--		}
--	},
	["ammunation_1"] = {
	['buy_price'] = 4000000,
	['sell_price'] = 3000000,
	['coord'] = {14.470663070679,-1106.0792236328,29.797006607056},
	['garage_coord'] = {-10.96, -1117.8, 27.74},
	['truck_parking_location'] = {16.65, -1122.05, 165.32},
	['sell_blip_coords'] = {
		{22.75, -1106.99, 29.8},
	},
	['deliveryman_coord'] = {18.69,-1116.16,79},
	['type'] = 'ammunation',
	['account'] = {
		['item'] = {
			[1] = {
				['icon'] = 'img/credit_card.png',
				['account'] = 'bank'
			},
			[2] = {
				['icon'] = 'img/cash.png',
				['account'] = 'cash'
			}
		},
		['store'] = 'bank',
	}
	},

    ["ammunation_2"] = {
        ['buy_price'] = 4000000,
        ['sell_price'] = 3000000,
        ['coord'] = {255.11,-46.32,69.94},
        ['garage_coord'] = {232.35, -48.34, 69.4},
        ['truck_parking_location'] = {236.97, -41.79, 69.73},
        ['sell_blip_coords'] = {
            {22.75, -1106.99, 29.8},
        },
        ['deliveryman_coord'] = {244.9,-41.33,69.9},
        ['type'] = 'ammunation',
        ['account'] = {
            ['item'] = {
                [1] = {
                    ['icon'] = 'img/credit_card.png',
                    ['account'] = 'bank'
                },
                [2] = {
                    ['icon'] = 'img/cash.png',
                    ['account'] = 'cash'
                }
            },
            ['store'] = 'bank',
        }
    },
    ["ammunation_3"] = {
        ['buy_price'] = 4000000,
        ['sell_price'] = 3000000,
        ['coord'] = {846.81,-1035.15,28.35},
        ['garage_coord'] = {841.04, -999.47, 27.65},
        ['truck_parking_location'] = {839.38,- 1018.28, 27.46},
        ['sell_blip_coords'] = {
            {841.75, -1033.94, 28.19},
        },
        ['deliveryman_coord'] = {841.27,-1021.88, 27.54},
        ['type'] = 'ammunation',
        ['account'] = {
            ['item'] = {
                [1] = {
                    ['icon'] = 'img/credit_card.png',
                    ['account'] = 'bank'
                },
                [2] = {
                    ['icon'] = 'img/cash.png',
                    ['account'] = 'cash'
                }
            },
            ['store'] = 'bank',
        }
    },
    ["ammunation_4"] = {
        ['buy_price'] = 4000000,
        ['sell_price'] = 3000000,
        ['coord'] = {2572.22,292.69,108.73},
        ['garage_coord'] = {2581.43, 319.59,108.43},
        ['truck_parking_location'] = {2565.24, 336.06, 108.46},
        ['sell_blip_coords'] = {
            {2567.31, 293.86, 108.73},
        },
        ['deliveryman_coord'] = {2566.76,304.06,108.61},
        ['type'] = 'ammunation',
        ['account'] = {
            ['item'] = {
                [1] = {
                    ['icon'] = 'img/credit_card.png',
                    ['account'] = 'bank'
                },
                [2] = {
                    ['icon'] = 'img/cash.png',
                    ['account'] = 'cash'
                }
            },
            ['store'] = 'bank',
        }
    },
    ["ammunation_5"] = {
        ['buy_price'] = 4000000,
        ['sell_price'] = 3000000,
        ['coord'] = {818.14,-2155.26,29.62},
        ['garage_coord'] = {812.25, -2125.79, 29.32},
        ['truck_parking_location'] = {822.81, -2140.01, 29.05},
        ['sell_blip_coords'] = {
            {809.55, -2157.67, 29.62},
        },
        ['deliveryman_coord'] = {814.47, -2147.24,29.46},
        ['type'] = 'ammunation',
        ['account'] = {
            ['item'] = {
                [1] = {
                    ['icon'] = 'img/credit_card.png',
                    ['account'] = 'bank'
                },
                [2] = {
                    ['icon'] = 'img/cash.png',
                    ['account'] = 'cash'
                }
            },
            ['store'] = 'bank',
        }
    },
	["ammunation_6"] = {
        ['buy_price'] = 4000000,
        ['sell_price'] = 3000000,
        ['coord'] = {-1122.09,2696.78,18.55},
        ['garage_coord'] = {-1109.14, 2681.93,18.9},
        ['truck_parking_location'] = {-1099.34, 2690.8, 19.57},
        ['sell_blip_coords'] = {
            {-1117.58, 2699.19, 18.55},
        },
        ['deliveryman_coord'] = {-1110.18, 2691.8, 18.6},
        ['type'] = 'ammunation',
        ['account'] = {
            ['item'] = {
                [1] = {
                    ['icon'] = 'img/credit_card.png',
                    ['account'] = 'bank'
                },
                [2] = {
                    ['icon'] = 'img/cash.png',
                    ['account'] = 'cash'
                }
            },
            ['store'] = 'bank',
        }
    },
	["ammunation_7"] = {
        ['buy_price'] = 4000000,
        ['sell_price'] = 3000000,
        ['coord'] = {-334.49,6081.73,31.45},
        ['garage_coord'] = {-321.42, 6091.65, 31.46},
        ['truck_parking_location'] = {-315.87, 6097.95, 31.46},
        ['sell_blip_coords'] = {
            {-330.3, 6084.51, 31.45},
        },
        ['deliveryman_coord'] = {-326.82,6073.26, 31.24},
        ['type'] = 'ammunation',
        ['account'] = {
            ['item'] = {
                [1] = {
                    ['icon'] = 'img/credit_card.png',
                    ['account'] = 'bank'
                },
                [2] = {
                    ['icon'] = 'img/cash.png',
                    ['account'] = 'cash'
                }
            },
            ['store'] = 'bank',
        }
    },
	["ammunation_8"] = {
        ['buy_price'] = 4000000,
        ['sell_price'] = 3000000,
        ['coord'] = {1689.43,3757.63,34.71},
        ['garage_coord'] = {1712.54, 3760.28, 34.18},
        ['truck_parking_location'] = {1711.15, 3750.46, 33.85},
        ['sell_blip_coords'] = {
            {1693.67, 3760.57, 34.71},
        },
        ['deliveryman_coord'] = {1697.97, 3749.78, 34.38},
        ['type'] = 'ammunation',
        ['account'] = {
            ['item'] = {
                [1] = {
                    ['icon'] = 'img/credit_card.png',
                    ['account'] = 'bank'
                },
                [2] = {
                    ['icon'] = 'img/cash.png',
                    ['account'] = 'cash'
                }
            },
            ['store'] = 'bank',
        }
    },
	["ammunation_8"] = {
        ['buy_price'] = 4000000,
        ['sell_price'] = 3000000,
        ['coord'] = {-3175.13,1084.27,20.84},
        ['garage_coord'] = {-3155.23, 1069.59, 20.68},
        ['truck_parking_location'] = {-3152.95, 1085.99, 20.7},
        ['sell_blip_coords'] = {
            {-3172.03, 1088.45, 20.84},
        },
        ['deliveryman_coord'] = {-3162.28,1084.81,20.85},
        ['type'] = 'ammunation',
        ['account'] = {
            ['item'] = {
                [1] = {
                    ['icon'] = 'img/credit_card.png',
                    ['account'] = 'bank'
                },
                [2] = {
                    ['icon'] = 'img/cash.png',
                    ['account'] = 'cash'
                }
            },
            ['store'] = 'bank',
        }
    }
}

-- Here you configure each type of market available to buy
Config.market_types = {
	['247store'] = {							-- Market type ID
		['stock_capacity'] = 1500,				-- Max stock capacity
		['max_employees'] = 5,					-- Max employees
		['upgrades'] = {						-- Definition of each upgrade
			['stock'] = {						-- Stock capacity
				['price'] = 250000,				-- Price to upgrade
				['level_reward'] = {			-- Reward of each level (max level: 5)
					[0] = 0,
					[1] = 50,
					[2] = 100,
					[3] = 150,
					[4] = 200,
					[5] = 300,
				}
			},
			['truck'] = {						-- Truck capacity
				['price'] = 500000,
				['level_reward'] = {
					[0] = 0,
					[1] = 25,
					[2] = 50,
					[3] = 100,
					[4] = 200,
					[5] = 300,
				}
			},
			['relationship'] = {				-- Relationship
				['price'] = 1000000,
				['level_reward'] = {
					[0] = 0,
					[1] = 5,
					[2] = 10,
					[3] = 15,
					[4] = 25,
					[5] = 40,
				}
			},
		},
		['market_items'] = {					-- Here you configure the items definitions
			['water'] = {						-- The item ID
				['name'] = "Wasser",				-- The item display name
				['price_to_customer'] = 80,		-- Price the customer will pay when buy the product in store
				['price_to_customer_min'] = 50,-- Min price that the owner will be able to set on this product
				['price_to_customer_max'] = 100,-- Max price that the owner will be able to set on this product
				['price_to_export'] = 80,		-- Price the owner will receive when exporting the item
				['price_to_owner'] = 50,		-- Price the store owner must pay when importing goods to your store
				['amount_to_owner'] = 100,		-- Amount of goods the owner will get when importing to store (This value can be increased if he upgraded his truck capacity)
				['amount_to_delivery'] = 100,	-- Max amount of goods the owner can set when creating a job to deliveryman
				['img'] = 'water.png',		-- Image file name of this item inside nui/img
				['page'] = 0					-- Set on which page this item will appear
			},

			['bread'] = {
				['name'] = "Brot",
				['price_to_customer'] = 100,
				['price_to_customer_min'] = 80,
				['price_to_customer_max'] = 130,
				['price_to_export'] = 100,
				['price_to_owner'] = 70,
				['amount_to_owner'] = 100,
				['amount_to_delivery'] = 100,
				['img'] = 'bread.png',
				['page'] = 0
			},

			['phone'] = {
				['name'] = "Handy",
				['price_to_customer'] = 5000,
				['price_to_customer_min'] = 4500,
				['price_to_customer_max'] = 5500,
				['price_to_export'] = 5000,
				['price_to_owner'] = 4000,
				['amount_to_owner'] = 50,
				['amount_to_delivery'] = 50,
				['img'] = 'phone.png',
				['page'] = 0
			},
			
			['paper'] = {
				['name'] = "Papes",
				['price_to_customer'] = 50,
				['price_to_customer_min'] = 50,
				['price_to_customer_max'] = 100,
				['price_to_export'] = 50,
				['price_to_owner'] = 10,
				['amount_to_owner'] = 50,
				['amount_to_delivery'] = 50,
				['img'] = 'paper.png',
				['page'] = 0
			},

			['rope'] = {
				['name'] = "Seil",
				['price_to_customer'] = 1000,
				['price_to_customer_min'] = 1000,
				['price_to_customer_max'] = 1300,
				['price_to_export'] = 1000,
				['price_to_owner'] = 800,
				['amount_to_owner'] = 50,
				['amount_to_delivery'] = 50,
				['img'] = 'rope.png',
				['page'] = 0
			},

			['cuffs'] = {
				['name'] = "Hanschellen",
				['price_to_customer'] = 2500,
				['price_to_customer_min'] = 2500,
				['price_to_customer_max'] = 3000,
				['price_to_export'] = 2500,
				['price_to_owner'] = 2300,
				['amount_to_owner'] = 50,
				['amount_to_delivery'] = 50,
				['img'] = 'cuffs.png',
				['page'] = 0
			},

			['blindfold'] = {
				['name'] = "Tüte",
				['price_to_customer'] = 1000,
				['price_to_customer_min'] = 1000,
				['price_to_customer_max'] = 1500,
				['price_to_export'] = 1000,
				['price_to_owner'] = 800,
				['amount_to_owner'] = 50,
				['amount_to_delivery'] = 50,
				['img'] = 'blindfold.png',
				['page'] = 0
			},


			['bandage'] = {
				['name'] = "Verbände",
				['price_to_customer'] = 10000,
				['price_to_customer_min'] = 10000,
				['price_to_customer_max'] = 11000,
				['price_to_export'] = 1000,
				['price_to_owner'] = 9000,
				['amount_to_owner'] = 50,
				['amount_to_delivery'] = 50,
				['img'] = 'bandage.png',
				['page'] = 0
			},

			['scratch_ticket'] = {
				['name'] = "Rubbellos",
				['price_to_customer'] = 8000,
				['price_to_customer_min'] = 8000,
				['price_to_customer_max'] = 9500,
				['price_to_export'] = 8000,
				['price_to_owner'] = 7000,
				['amount_to_owner'] = 100,
				['amount_to_delivery'] = 100,
				['img'] = 'scratch_ticket.png',
				['page'] = 0
			},

			['tablet'] = {
				['name'] = "Tablet",
				['price_to_customer'] = 15000,
				['price_to_customer_min'] = 15000,
				['price_to_customer_max'] = 16000,
				['price_to_export'] = 15000,
				['price_to_owner'] = 14000,
				['amount_to_owner'] = 35,
				['amount_to_delivery'] = 35,
				['img'] = 'tablet.png',
				['page'] = 0
			},

			['lappen'] = {
				['name'] = "Lappen",
				['price_to_customer'] = 1500,
				['price_to_customer_min'] = 1500,
				['price_to_customer_max'] = 2500,
				['price_to_export'] = 1500,
				['price_to_owner'] = 1000,
				['amount_to_owner'] = 100,
				['amount_to_delivery'] = 100,
				['img'] = 'lappen.png',
				['page'] = 0
			},

			['ice'] = {
				['name'] = "Eis",
				['price_to_customer'] = 50,
				['price_to_customer_min'] = 50,
				['price_to_customer_max'] = 60,
				['price_to_export'] = 50,
				['price_to_owner'] = 40,
				['amount_to_owner'] = 100,
				['amount_to_delivery'] = 100,
				['img'] = 'ice.png',
				['page'] = 0
			},

			['contract'] = {
				['name'] = "Vertrag",
				['price_to_customer'] = 50,
				['price_to_customer_min'] = 50,
				['price_to_customer_max'] = 60,
				['price_to_export'] = 50,
				['price_to_owner'] = 40,
				['amount_to_owner'] = 100,
				['amount_to_delivery'] = 100,
				['img'] = 'contract.png',
				['page'] = 0
			},

			['repairkit'] = {
				['name'] = "Öl & Reifen Flickset",
				['price_to_customer'] = 3000,
				['price_to_customer_min'] = 2500,
				['price_to_customer_max'] = 3500,
				['price_to_export'] = 3000,
				['price_to_owner'] = 2000,
				['amount_to_owner'] = 35,
				['amount_to_delivery'] = 35,
				['img'] = 'repairkit.png',
				['page'] = 0
			},
		},

		['pagination'] = {						-- Create pages to your market items (max 10 pages)
			[0] = {
				['page_name'] = "Allgemein",
				['page_desc'] = "Allgemein",
				['page_icon'] = '<i class="fas fa-store"></i>'
			}
		},
		['blips'] = {							-- Create the blips on map
			['id'] = 52,						-- Blip ID [Set this value 0 to dont have blip]
			['name'] = "Market",				-- Blip Name [Will be replaced when the owner rename the store]
			['color'] = 4,						-- Blip Color
			['scale'] = 0.8,					-- Blip Scale
		}
	},

	['ammunation'] = {
		['stock_capacity'] = 1500,
		['max_employees'] = 5,
		['upgrades'] = {
			['stock'] = {
				['price'] = 250000,
				['level_reward'] = {
					[0] = 0,
					[1] = 10,
					[2] = 20,
					[3] = 30,
					[4] = 40,
					[5] = 50,
				}
			},
			['truck'] = {
				['price'] = 500000,
				['level_reward'] = {
					[0] = 0,
					[1] = 10,
					[2] = 20,
					[3] = 40,
					[4] = 70,
					[5] = 90,
				}
			},
			['relationship'] = {
				['price'] = 1000000,
				['level_reward'] = {
					[0] = 0,
					[1] = 3,
					[2] = 5,
					[3] = 8,
					[4] = 10,
					[5] = 15,
				}
			},
		},
		['market_items'] = {
			['WEAPON_SNSPISTOL'] = {
				['name'] = "SNS Pistole",						-- name
				['price_to_customer'] = 85000,			-- einkaufspreis
				['price_to_customer_min'] = 84999,		-- Verkaufspreis min
				['price_to_customer_max'] = 95000,		-- Verkaufspreis max
				['price_to_export'] = 85000,				-- Verkaufspreis Export
				['price_to_owner'] = 80000,				-- 
				['amount_to_owner'] = 20,
				['amount_to_delivery'] = 20,
				['img'] = 'WEAPON_SNSPISTOL.png',					-- bild
				['page'] = 0
			},

			['WEAPON_FLASHLIGHT'] = {
				['name'] = "Taschenlampe",
				['price_to_customer'] = 40000,
				['price_to_customer_min'] = 40000,
				['price_to_customer_max'] = 50000,
				['price_to_export'] = 40000,
				['price_to_owner'] = 38000,
				['amount_to_owner'] = 20,
				['amount_to_delivery'] = 20,
				['img'] = 'WEAPON_FLASHLIGHT.png',
				['page'] = 0
			},

			['WEAPON_BAT'] = {
				['name'] = "Baseballschläger",
				['price_to_customer'] = 65000,
				['price_to_customer_min'] = 65000,
				['price_to_customer_max'] = 70000,
				['price_to_export'] = 65000,
				['price_to_owner'] = 65000,
				['amount_to_owner'] = 20,
				['amount_to_delivery'] = 20,
				['img'] = 'WEAPON_BAT.png',
				['page'] = 0
			},	
			
			['binocular'] = {
				['name'] = "Fernglas",
				['price_to_customer'] = 3500,
				['price_to_customer_min'] = 3500,
				['price_to_customer_max'] = 4500,
				['price_to_export'] = 3500,
				['price_to_owner'] = 3000,
				['amount_to_owner'] = 20,
				['amount_to_delivery'] = 20,
				['img'] = 'binocular.png',
				['page'] = 0
			},	

			['WEAPON_PEPPERSPRAY'] = {
				['name'] = "Pfefferspray",
				['price_to_customer'] = 35000,
				['price_to_customer_min'] = 35000,
				['price_to_customer_max'] = 45000,
				['price_to_export'] = 35000,
				['price_to_owner'] = 30000,
				['amount_to_owner'] = 20,
				['amount_to_delivery'] = 20,
				['img'] = 'WEAPON_PEPPERSPRAY.png',
				['page'] = 0
			},	

			['WEAPON_ANTIDOTE'] = {
				['name'] = "Gegenmittel",
				['price_to_customer'] = 10000,
				['price_to_customer_min'] = 10000,
				['price_to_customer_max'] = 15000,
				['price_to_export'] = 10000,
				['price_to_owner'] = 9500,
				['amount_to_owner'] = 20,
				['amount_to_delivery'] = 20,
				['img'] = 'WEAPON_ANTIDOTE.png',
				['page'] = 0
			},	

			['weabox'] = {
				['name'] = "Munition",
				['price_to_customer'] = 999,
				['price_to_customer_min'] = 999,
				['price_to_customer_max'] = 1500,
				['price_to_export'] = 1200,
				['price_to_owner'] = 500,
				['amount_to_owner'] = 20,
				['amount_to_delivery'] = 20,
				['img'] = 'weabox.png',
				['page'] = 0
			},	
		},
		['pagination'] = {
--[[			[0] = {
				['page_name'] = "Melee weapons",
				['page_desc'] = "A melee weapon is any handheld weapon used in hand-to-hand combat",
				['page_icon'] = '<img src="img/meleeweaponicon.svg" style="padding:12px">'
			},
			[1] = {
				['page_name'] = "Pistols",
				['page_desc'] = "Ranged weapon is any weapon capable of engaging targets at a distance beyond immediate physical contact",
				['page_icon'] = '<img src="img/pistolweaponicon.svg" style="padding:8px">'
			}, --]]
			[0] = {
				['page_name'] = "Allgemein",
				['page_desc'] = "Allgemein",
				['page_icon'] = '<img src="img/otherweaponicon.svg" style="padding:7px">'
			}
		},
		['blips'] = {
			['id'] = 110,
			['name'] = "Ammunation",
			['color'] = 4,
			['scale'] = 0.8,
		}
	}
}

-- Here you can configure the permissions for each employee role
-- 1 = Basic Access
-- 2 = Advanced Access
-- 3 = Full Access
-- When setting a permission to 1, any employee will be able to access that function/page
-- When setting a permission to 2, only the employees with the advanced access and full access will be able to access that function/page
-- When setting a permission to 3, only the employees with the full access will be able to access that function/page
-- When setting a permission to 4, only the owner will be able to access that function/page
Config.roles_permissions = {
	['functions'] = {				-- These are the actions (when a button is clicked)
		['createJob'] = 2,
		['deleteJob'] = 2,
		['renameMarket'] = 3,
		['setPrice'] = 2,
		['buyUpgrade'] = 2,
		['hideBalance'] = 2,
		['showBalance'] = 2,
		['withdrawMoney'] = 3,
		['depositMoney'] = 3,
		['sellMarket'] = 4,
		['storeProductFromInventory'] = 1,
		['hirePlayer'] = 3,
		['firePlayer'] = 3,
		['changeRole'] = 3,
		['giveComission'] = 3,
		['startContractImport'] = 1,
		['startContractExport'] = 1
	},
	['ui_pages'] = {				-- These are the UI pages
		['main'] = 1,
		['goods'] = 1,
		['hire'] = 2,
		['employee'] = 3,
		['upgrades'] = 2,
		['bank'] = 3
	}
}

-- Setting to remove inactive stores
Config.clear_stores = {
	['active'] = true,				-- Set to false to disable this function
	['min_stock_amount'] = 30,		-- Minimum percentage of stock to consider an inactive store. Stores that have been inactive for a long time will be removed
	['min_stock_variety'] = 70,		-- Minimum percentage of variety of products in stock to consider an inactive store. Stores that have been inactive for a long time will be removed
	['cooldown'] = 72				-- Time (in hours) that the store needs to be below the minimum amount of stock to be removed
}

-- Trucks for each level when upgrade the truck cargo
Config.trucks = {
	[0] = 'speedo',
	[1] = 'gburrito',
	[2] = 'mule',
	[3] = 'mule3',
	[4] = 'pounder',
	[5] = 'pounder2'
}
Config.keyToUnlockTruck = 73 	-- Key X

-- Cargo delivery locations
Config.delivery_locations = {
	[1] = { -952.31, -1077.87, 2.48 },
	[2] = { -978.23, -1108.09, 2.16 },
	[3] = { -1024.49, -1139.6, 2.75 }, 
	[4] = { -1063.76, -1159.88, 2.56 }, 
	[5] = { -1001.68, -1218.78, 5.75 }, 
	[6] = { -1171.54, -1575.61, 4.51 }, 
	[7] = { -1097.94, -1673.36, 8.4 }, 
	[8] = { -1286.17, -1267.12, 4.52 }, 
	[9] = { -1335.75, -1146.55, 6.74 }, 
	[10] = { -1750.47, -697.09, 10.18 }, 
	[11] = { -1876.84, -584.39, 11.86 }, 
	[12] = { -1772.23, -378.12, 46.49 }, 
	[13] = { -1821.38, -404.97, 46.65 }, 
	[14] = { -1965.33, -296.96, 41.1 }, 
	[15] = { -3089.24, 221.49, 14.07 }, 
	[16] = { -3088.62, 392.3, 11.45 },
	[17] = { -3077.98, 658.9, 11.67 }, 
	[18] = { -3243.07, 931.84, 17.23 },
	[19] = { 1230.8, -1590.97, 53.77 }, 
	[20] = { 1286.53, -1604.26, 54.83 }, 
	[21] = { 1379.38, -1515.23, 58.24 }, 
	[22] = { 1379.38, -1515.23, 58.24 }, 
	[23] = { 1437.37, -1492.53, 63.63 }, 
	[24] = { 450.04, -1863.49, 27.77 },
	[25] = { 403.75, -1929.72, 24.75 }, 
	[26] = { 430.16, -1559.31, 32.8 }, 
	[27] = { 446.06, -1242.17, 30.29 },
	[28] = { 322.39, -1284.7, 30.57 }, 
	[29] = { 369.65, -1194.79, 31.34 },
	[30] = { 474.27, -635.05, 25.65 }, 
	[31] = { 158.87, -1215.65, 29.3 }, 
	[32] = { 154.68, -1335.62, 29.21 }, 
	[33] = { 215.54, -1461.67, 29.19 },
	[34] = { 167.46, -1709.3, 29.3 },
	[35] = { -444.47, 287.68, 83.3 }, 
	[36] = { -179.56, 314.25, 97.88 }, 
	[37] = { -16.07, 216.7, 106.75 }, 
	[38] = { 164.02, 151.87, 105.18 },
	[39] = { 840.2, -181.93, 74.19 }, 
	[40] = { 952.27, -252.17, 67.77 },
	[41] = { 1105.27, -778.84, 58.27 }, 
	[42] = { 1099.59, -345.68, 67.19 }, 
	[43] = { -1211.12, -401.56, 38.1 }, 
	[44] = { -1302.69, -271.32, 40.0 }, 
	[45] = { -1468.65, -197.3, 48.84 }, 
	[46] = { -1583.18, -265.78, 48.28 }, 
	[47] = { -603.96, -774.54, 25.02 },
	[48] = { -805.14, -959.54, 18.13 }, 
	[49] = { -325.07, -1356.35, 31.3 }, 
	[50] = { -321.94, -1545.74, 31.02 }, 
	[51] = { -428.95, -1728.13, 19.79 }, 
	[52] = { -582.38, -1743.65, 22.44 }, 
	[53] = { -670.43, -889.09, 24.5 },
	
	[54] = { 1691.4, 3866.21, 34.91 }, 
	[55] = { 1837.93, 3907.12, 33.26 },
	[56] = { 1937.08, 3890.89, 32.47}, 
	[57] = { 2439.7, 4068.45, 38.07 },
	[58] = { 2592.26, 4668.98, 34.08 }, 
	[59] = { 1961.53, 5184.91, 47.98 },
	[60] = { 2258.59, 5165.84, 59.12 }, 
	[61] = { 1652.7, 4746.1, 42.03 },
	[62] = { -359.09, 6062.05, 31.51 }, 
	[63] = { -160.13, 6432.2, 31.92 },
	[64] = { 33.33, 6673.27, 32.19 }, 
	[65] = { 175.03, 6643.14, 31.57 },
	[66] = { 22.8, 6488.44, 31.43 }, 
	[67] = { 64.39, 6309.17, 31.38 },
	[68] = { 122.42, 6406.02, 31.37 }, 
	[69] = { 1681.2, 6429.11, 32.18 },
	[70] = { 2928.01, 4474.74, 48.04 }, 
	[71] = { 2709.92, 3454.83, 56.32 },
	[72] = { -688.75, 5788.9, 17.34 }, 
	[73] = { -436.13, 6154.93, 31.48 },
	[74] = { -291.09, 6185.0, 31.49 }, 
	[75] = { 405.31, 6526.38, 27.69 },
	[76] = { -20.38, 6567.13, 31.88 }, 
	[77] = { -368.06, 6341.4, 29.85 },
	[78] = { 1842.89, 3777.72, 33.16 }, 
	[79] = { 1424.82, 3671.73, 34.18 },
	[80] = { 996.54, 3575.55, 34.62 }, 
	[81] = { 1697.52, 3596.14, 35.56 },
	[82] = { 2415.05, 5005.35, 46.68 }, 
	[83] = { 2336.21, 4859.41, 41.81},
	[84] = { 1800.9, 4616.07, 37.23 },
	[85] = { -453.3, 6336.9, 13.11 },
	[86] = { -425.4, 6356.43, 13.33 },
	[87] = { -481.9, 6276.47, 13.42 },
	[88] = { -693.92, 5761.95, 17.52 },
	[89] = { -682.03, 5770.96, 17.52 },
	[90] = { -379.44, 6062.07, 31.51 },
	[91] = { -105.68, 6528.7, 30.17 },
	[92] = { 35.02, 6662.61, 32.2 },
	[93] = { 126.41, 6353.64, 31.38 },
	[94] = { 48.15, 6305.99, 31.37 },
	[95] = { 1417.68, 6343.83, 24.01 },
	[96] = { 1510.21, 6326.28, 24.61 },
	[97] = { 1698.22, 6425.66, 32.77 },
	[98] = { 2434.69, 5011.7, 46.84 },
	[99] = { 1718.88, 4677.32, 43.66 },
	[100] = { 1673.21, 4958.09, 42.35 },
	[101] = { 1364.33, 4315.43, 37.67 },
	[102] = { -1043.6, 5326.84, 44.58 },
	[103] = { -329.63, 6150.58, 32.32 },
	[104] = { -374.41, 6191.04, 31.73 },
	[105] = { -356.63, 6207.34, 31.85 },
	[106] = { -347.15, 6224.69, 31.7 },
	[107] = { -315.61, 6194.0, 31.57 },
	[108] = { -33.3, 6455.87, 31.48 },
	[109] = { 405.52, 6526.59, 27.7 },
	[110] = { 1470.41, 6513.71, 21.23 },
	[111] = { 1593.73, 6460.56, 25.32 },
	[112] = { 1741.31, 6420.19, 35.05 },
}

-- Product export locations
Config.export_locations = {
	{-758.14,5540.96,33.49,110.53},
	{-3046.19,143.27,11.6,11.14},
	{-1153.01,2672.99,18.1,312.25},
	{622.67,110.27,92.59,340.75},
	{-574.62,-1147.27,22.18,177.7},
	{376.31,2638.97,44.5,286.38},
	{1738.32,3283.89,41.13,16.24},
	{1419.98,3618.63,34.91,195.33},
	{1452.67,6552.02,14.89,138.69},
	{3472.4,3681.97,33.79,76.44},
	{2485.73,4116.13,38.07,66.71},
	{65.02,6345.89,31.22,206.64},
	{-303.28,6118.17,31.5,135.24},
	{-63.41,-2015.25,18.02,299.48},
	{-46.35,-2112.38,16.71,290.84},
	{-746.6,-1496.67,5.01,28.08},
	{369.54,272.07,103.11,247.94},
	{907.61,-44.12,78.77,323.08},
	{-1517.31,-428.29,35.45,55.77},
	{235.04,-1520.18,29.15,316.76},
	{34.8,-1730.13,29.31,226.06},
	{350.4,-2466.9,6.4,169.38},
	{1213.97,-1229.01,35.35,270.74},
	{1395.7,-2061.38,52.0,135.81},
	{729.09,-2023.63,29.31,268.75},
	{840.72,-1952.59,28.85,81.46},
	{551.76,-1840.26,25.34,40.72},
	{723.78,-1372.08,26.29,106.65},
	{-339.92,-1284.25,31.32,89.06},
	{1137.23,-1285.05,34.6,189.65},
	{466.93,-1231.55,29.95,267.14},
	{442.28,-584.28,28.5,252.12},
	{1560.52,888.69,77.46,19.02},
	{2561.78,426.67,108.46,301.57},
	{569.21,2730.83,42.07,91.35},
	{2665.4,1700.63,24.49,269.33},
	{1120.1,2652.5,38.0,181.77},
	{2004.23,3071.87,47.06,237.58},
	{2038.78,3175.7,45.09,140.47},
	{1635.54,3562.84,35.23,296.61},
	{2744.55,3412.43,56.57,247.48},
	{1972.17,3839.16,32.0,304.36},
	{1980.59,3754.65,32.18,211.64},
	{1716.0,4706.41,42.69,91.44},
	{1691.36,4918.42,42.08,57.29},
	{1971.07,5165.12,47.64,125.93},
	{1908.78,4932.06,48.97,340.08},
	{140.79,-1077.85,29.2,262.4},
	{-323.98,-1522.86,27.55,258.59},
	{-1060.53,-221.7,37.84,299.01},
	{2471.47,4463.07,35.3,277.56},
	{2699.47,3444.81,55.8,153.49},
	{-1060.53,-221.7,37.84,299.01},
	{2655.38,3281.01,55.24,63.99},
	{2730.39,2778.2,36.01,134.51},
	{-2966.68,363.37,14.77,359.8},
	{2788.89,2816.49,41.72,296.22},
	{-604.45,-1212.24,14.95,227.43},
	{2534.83,2589.08,37.95,2.48},
	{-143.31,205.88,92.12,86.41},
	{2347.04,2633.25,46.67,30.15},
	{860.47,-896.87,25.53,181.8},
	{973.34,-1038.19,40.84,272.3},
	{-409.04,1200.44,325.65,164.59},
	{-1617.77,3068.17,32.27,94.64},
	{-71.8,-1089.98,26.56,339.06},
	{-409.04,1200.44,325.65,164.59},
	{-1617.77,3068.17,32.27,94.64},
	{1246.34,1860.78,79.47,315.78},
	{-1777.63,3082.36,32.81,236.17},
	{-1775.87,3088.13,32.81,239.97},
	{-1827.5,2934.11,32.82,59.53},
	{-2123.69,3270.14,32.82,145.14},
	{-2444.59,2981.63,32.82,283.55},
	{-2448.59,2962.8,32.82,333.19},
	{-2277.86,3176.57,32.81,236.61},
	{-2969.0,366.46,14.77,292.99},
	{-1637.61,-814.53,10.17,139.15},
	{-1494.72,-891.67,10.11,73.06},
	{-902.27,-1528.42,5.03,106.23},
	{-1173.93,-1749.87,3.97,211.53},
	{-1087.8,-2047.55,13.23,314.93},
	{-1133.74,-2035.99,13.21,314.41},
	{-1234.4,-2092.3,13.93,173.93},
	{-1025.97,-2223.62,8.99,224.96},
	{850.42,2197.69,51.93,243.19},
	{42.61,2803.45,57.88,145.49},
	{-1193.54,-2155.4,13.2,138.82},
	{-1184.37,-2185.67,13.2,336.13},
	{2041.76,3172.26,44.98,155.2},
	{-465.48,-2169.09,10.01,9.47},
	{-3150.77,1086.55,20.7,339.24},
	{-433.69,-2277.29,7.61,268.97},
	{-395.18,-2182.97,10.29,94.54},
	{-3029.7,591.68,7.79,199.33},
	{-3029.7,591.68,7.79,199.33},
	{-1007.29,-3021.72,13.95,65.31},
	{-61.32,-1832.75,26.8,227.87},
	{822.72,-2134.28,29.29,349.36},
	{942.22,-2487.76,28.34,89.41},
	{729.29,-2086.53,29.3,89.29},
	{783.08,-2523.98,20.51,5.67},
	{717.8,-2111.18,29.22,272.62},
	{787.05,-1612.38,31.17,48.33},
	{913.52,-1556.87,30.74,272.14},
	{777.64,-2529.46,20.13,96.09},
	{846.71,-2496.12,28.34,81.07},
	{711.79,-1395.19,26.35,103.31},
	{723.38,-1286.3,26.3,90.13},
	{983.0,-1230.77,25.38,121.4},
	{818.01,-2422.85,23.6,174.28},
	{885.53,-1166.38,24.99,94.77},
	{700.85,-1106.93,22.47,163.11},
	{882.26,-2384.1,28.0,179.16},
	{977.83,-1821.21,31.17,354.2},
	{-1138.73,-759.77,18.87,234.36},
	{938.71,-1154.36,25.38,178.46},
	{973.0,-1156.18,25.43,267.36},
	{689.41,-963.48,23.49,178.61},
	{140.72,-375.29,43.26,336.19},
	{-497.09,-62.13,39.96,353.27},
	{-606.34,187.43,70.01,270.65},
	{117.12,-356.15,42.59,252.09},
	{53.91,-1571.07,29.47,137.1},
	
	{1528.1,1719.32,109.97,34.6},
	{1411.29,1060.33,114.34,269.14},
	{1145.76,-287.73,68.96,284.29},
	{1117.71,-488.25,65.25,166.07},
	{874.28,-949.16,26.29,358.46},
	{829.28,-874.08,25.26,270.18},
	{725.37,-874.53,24.67,265.96},
	{693.66,-1090.43,22.45,174.62},
	{977.51,-1013.67,41.32,270.83},
	{901.89,-1129.9,24.08,86.26},
	{911.7,-1258.04,25.58,33.69},
	{847.06,-1397.72,26.14,151.79},
	{830.67,-1409.13,26.16,334.64},
	{130.47,-1066.12,29.2,160.09},
	{-52.79,-1078.65,26.93,67.2},
	{-131.74,-1097.38,21.69,335.25},
	{-621.47,-1106.05,22.18,1.07},
	{-668.65,-1182.07,10.62,208.79},
	{-111.84,-956.71,27.27,339.83},
	{-1323.51,-1165.11,4.73,359.27},
	{-1314.65,-1254.96,4.58,19.95},
	{-1169.18,-1768.78,3.87,306.82},
	{-1343.38,-744.02,22.28,309.26},
	{-1532.84,-578.16,33.63,304.2},
	{-1461.4,-362.39,43.89,219.06},
	{-1457.25,-384.15,38.51,114.12},
	{-1544.42,-411.45,41.99,226.04},
	{-1432.72,-250.32,46.37,130.83},
	{-1040.24,-499.88,36.07,118.78},
	{346.43,-1107.19,29.41,177.11},
	{523.99,-2112.7,5.99,182.08},
	{977.19,-2539.34,28.31,353.75,357.42},
	{1101.01,-2405.39,30.76,259.61},
	{1591.9,-1714.0,88.16,120.75},
	{1693.41,-1497.45,113.05,66.92},
	{1029.44,-2501.31,28.43,149.34},
	{2492.55,-320.89,93.0,82.83},
	{2846.31,1463.1,24.56,74.93},
	{3631.05,3768.61,28.52,320.0},
	{3572.5,3665.53,33.9,75.93},
	{2919.03,4337.85,50.31,203.77},
	{2521.47,4203.47,39.95,327.93},
	{2926.2,4627.28,48.55,143.26},
	{3808.59,4463.22,4.37,87.61},
	{3323.71,5161.1,18.4,147.02},
	{2133.06,4789.57,40.98,26.62},
	{1900.83,4913.82,48.87,154.21},
	{381.06,3591.37,33.3,82.49},
	{642.8,3502.47,34.09,95.04},
	{277.33,2884.71,43.61,296.91},
	{-60.3,1961.45,190.19,294.86},
	{225.63,1244.33,225.46,194.24},
	{-1136.15,4925.14,220.01,262.73},
	{-519.96,5243.84,79.95,72.76},
	{-602.87,5326.63,70.46,168.65},
	{-797.95,5400.61,34.24,86.78},
	{-776.0,5579.11,33.49,167.58},
	{-704.2,5772.55,17.34,68.44},
	{-299.24,6300.27,31.5,134.2},
	{402.52,6619.61,28.26,357.71},
	{-247.72,6205.46,31.49,45.5},
	{-267.5,6043.45,31.78,50.59},
	{-16.29,6452.44,31.4,226.65},
	{2204.73,5574.04,53.74,351.31},
	{1638.98,4840.41,42.03,185.92},
	{1961.26,4640.93,40.71,293.6},
	{1776.61,4584.67,37.65,181.45},
	{137.29,281.73,109.98,335.6},
	{588.37,127.87,98.05,250.47},
	{199.8,2788.78,45.66,276.37},
	{708.58,-295.1,59.19,277.93},
	{581.28,2799.43,42.1,1.52},
	{1296.73,1424.35,100.45,178.89},
	{955.85,-22.89,78.77,147.51}
}

Config.createTable = true