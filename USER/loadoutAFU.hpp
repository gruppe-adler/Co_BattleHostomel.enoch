#ifdef NIGHTVISION
  #define NVITEM "rhsusf_ANPVS_15"
#else
  #define NVITEM ""
#endif

#ifdef LASERS
  #define LLITEM "rhsusf_acc_anpeq15A"
#else
  #define LLITEM ""
#endif

#ifdef GUNLIGHTS
  #define LLITEM "rhsusf_acc_M952V"
#endif

#ifdef SUPPRESSORS
  #define SUPPRESSORITEM "rhsusf_acc_nt4_black"
#else
  #define SUPPRESSORITEM ""
#endif

class AFU {
    class AllUnits {
        uniform[] = {"Inf01", "Inf02", "Inf03", "Inf05", "Soldier03", "Inf06", "Inf08", "Soldier02", "Soldier05"};
        vest[] = {"vest05", "vest08", "vest02r", "vest03", "vest06", "vest01r"};
        backpack = "";
        headgear[] = {"h2", "h4"};
        primaryWeapon[] = {"arifle_AK12U_F", "arifle_AK12U_arid_F", "arifle_AK12U_lush_F", "arifle_AK12_F", "arifle_AK12_arid_F","arifle_AK12_lush_F"};
        primaryWeaponMagazine[] = {"rhs_30Rnd_545x39_7N10_2mag_AK", "rhs_30Rnd_545x39_7N10_2mag_camo_AK", "rhs_30Rnd_545x39_7N10_2mag_plum_AK", "rhs_30Rnd_545x39_7N10_camo_AK", "rhs_30Rnd_545x39_7N10_plum_AK", "rhs_30Rnd_545x39_7N6_AK"};
        primaryWeaponMuzzle = SUPPRESSORITEM;
        primaryWeaponPointer = LLITEM;
        primaryWeaponOptics = "";
        primaryWeaponUnderbarrel = "";
        primaryWeaponUnderbarrelMagazine = "";
        secondaryWeapon = "";
        secondaryWeaponMagazine = "";
        handgunWeapon = "rhsusf_weap_m9";
        handgunWeaponMagazine = "rhsusf_mag_15Rnd_9x19_JHP";
        binoculars = "Binocular";
        map = "ItemMap";
        compass = "ItemCompass";
        watch = "ItemWatch";
        gps = "ItemGPS";
        radio = "tfar_anprc152";
        nvgoggles = NVITEM;
        goggles = "";
    };
    class Type {
        //Rifleman
        class Soldier_F {
            addItemsToUniform[] = {
                LIST_1("ACE_MapTools"),
                LIST_1("ACE_DefusalKit"),
                LIST_2("ACE_CableTie"),
                LIST_1("ACE_Flashlight_MX991"),

                GRAD_FACTIONS_MEDICITEMS_INF_LIST
            };
            addItemsToVest[] = {
                LIST_2("HandGrenade"),
                LIST_2("SmokeShell"),
                LIST_2("rhsusf_mag_15Rnd_9x19_JHP"),
                LIST_7("rhs_30Rnd_545x39_7N6_AK")
            };
        };

        //Asst. Autorifleman
        class soldier_AAR_F: Soldier_F {
            addItemsToBackpack[] = {
                LIST_2("rhs_100Rnd_762x54mmR"),
                "rhs_100Rnd_762x54mmR"
            };
        };

        //Asst. Gunner (MMG) / Ammo Bearer
        class soldier_A_F: Soldier_F {
            addItemsToBackpack[] = {
                LIST_2("rhsusf_100Rnd_762x51_m62_tracer"),
                "rhsusf_100Rnd_762x51"
            };
        };

        //Asst. Gunner (HMG/GMG)
        class support_AMG_F: Soldier_F {
            backpack = "RHS_M2_MiniTripod_Bag";
        };

        //Asst. Missile Specialist (AA)
        class soldier_AAA_F: Soldier_F {
            backpack = "rhsusf_assault_eagleaiii_ocp";
            addItemsToBackpack[] = {
                "rhs_fim92_mag"
            };
        };

        //Asst. Missile Specialist (AT)
        class soldier_AAT_F: Soldier_F {
            backpack = "B_Carryall_cbr";
            addItemsToBackpack[] = {
                "rhs_fgm148_magazine_AT"
            };
        };

        //Autorifleman
        class soldier_AR_F: Soldier_F {
            primaryWeapon = "rhs_weap_pkm";
            primaryWeaponMagazine = "rhs_100Rnd_762x54mmR";
            handgunWeapon = "";
            handgunWeaponMagazine = "";
            backpack = "BackPack01";
            addItemsToBackpack[] = {
                LIST_2("rhs_100Rnd_762x54mmR"),
                "rhs_100Rnd_762x54mmR"
            };
            addItemsToVest[] = {
                LIST_2("HandGrenade"),
                LIST_2("SmokeShell")
            };
        };

        //Combat Life Saver
        class medic_F: Soldier_F {
            vest = "rhsusf_iotv_ocp_Medic";
            backpack = "B_Kitbag_cbr";
            addItemsToUniform[] = {
                "ACE_MapTools",
                "ACE_Flashlight_MX991"
            };
            addItemsToVest[] = {
                LIST_2("SmokeShellPurple"),
                LIST_8("SmokeShell"),
                LIST_2("rhsusf_mag_15Rnd_9x19_JHP"),
                LIST_8("rhs_30Rnd_545x39_7N6_AK")
            };

            class Rank {
                class PRIVATE {
                    GRAD_FACTIONS_MEDICITEMS_CFR
                };
                class CORPORAL {
                    GRAD_FACTIONS_MEDICITEMS_SQ
                };
                class SERGEANT {
                    GRAD_FACTIONS_MEDICITEMS_PT
                };
                class LIEUTENANT: SERGEANT {};
                class CAPTAIN: SERGEANT {};
                class MAJOR: SERGEANT {};
                class COLONEL: SERGEANT {};
            };
        };

        //Explosive Specialist
        class soldier_exp_F: Soldier_F {
            backpack = "rhsusf_assault_eagleaiii_ocp";
            addItemsToBackpack[] = {
                "ACE_Clacker",
                "ACE_M26_Clacker",
                "SatchelCharge_Remote_Mag",
                LIST_3("DemoCharge_Remote_Mag")
            };
        };

        //Engineer
        class engineer_F: Soldier_F {
            backpack = "rhs_assault_umbts_engineer_empty";
            secondaryWeapon = "hgun_esd_01_F";
            addItemsToBackpack[] = {
                "ace_wirecutter",
                "ace_entrenchingtool"
            };
        };

        //Grenadier
        class Soldier_GL_F: Soldier_F {
            primaryWeapon[] = {"arifle_AK12_GL_F", "arifle_AK12_GL_arid_F", "arifle_AK12_GL_lush_F"};
            addItemsToVest[] = {
                LIST_2("HandGrenade"),
                LIST_2("SmokeShell"),
                LIST_2("rhsusf_mag_15Rnd_9x19_JHP"),
                LIST_7("rhs_30Rnd_545x39_7N6_AK"),
                LIST_6("rhs_mag_M441_HE"),
                LIST_2("rhs_mag_m713_Red")
            };
        };

        //Heavy Gunner (MMG)
        class HeavyGunner_F: Soldier_F {
            primaryWeapon = "rhs_weap_m240B";
            primaryWeaponMagazine = "rhsusf_100Rnd_762x51";
            primaryWeaponMuzzle = "";
            handgunWeapon = "";
            handgunWeaponMagazine = "";
            backpack = "rhsusf_assault_eagleaiii_ocp";
            addItemsToBackpack[] = {
                LIST_2("rhsusf_100Rnd_762x51_m62_tracer"),
                "rhsusf_100Rnd_762x51"
            };
            addItemsToVest[] = {
                LIST_2("HandGrenade"),
                LIST_2("SmokeShell")
            };
        };

        //Gunner (HMG/GMG)
        class support_MG_F: Soldier_F {
            backpack = "RHS_M2_Gun_Bag";
        };

        //Marksman
        class soldier_M_F: Soldier_F {
            primaryWeapon = "rhs_weap_sr25_ec";
            primaryWeaponMagazine = "rhsusf_20Rnd_762x51_SR25_m118_special_Mag";
            primaryWeaponMuzzle = "";
            primaryWeaponPointer = "";
            primaryWeaponOptics = "optic_DMS";
            primaryWeaponUnderbarrel = "bipod_01_F_blk";
            addItemsToVest[] = {
                LIST_2("SmokeShell"),
                LIST_2("rhsusf_mag_15Rnd_9x19_JHP"),
                LIST_7("rhsusf_20Rnd_762x51_SR25_m118_special_Mag")
            };
        };

        //Missile Specialist (AA)
        class soldier_AA_F: Soldier_F {
            secondaryWeapon = "rhs_weap_fim92";
            secondaryWeaponMagazine = "rhs_fim92_mag";
            backpack = "BackPack01";
            addItemsToBackpack[] = {
                "rhs_fim92_mag"
            };
        };

        //Missile Specialist (AT)
        class soldier_AT_F: Soldier_F {
            secondaryWeapon = "rhs_weap_fgm148";
            secondaryWeaponMagazine = "rhs_fgm148_magazine_AT";
            backpack = "B_Carryall_cbr";
            addItemsToBackpack[] = {
                "rhs_fgm148_magazine_AT"
            };
        };

        //Repair Specialist
        class soldier_repair_F: Soldier_F {
            backpack = "rhsusf_assault_eagleaiii_ocp";
            addItemsToBackpack[] = {
                "ToolKit",
                "ACE_wirecutter"
            };
        };

        //Rifleman (AT)
        class soldier_LAT_F: Soldier_F {
            secondaryWeapon = "rhs_weap_M136";
            backpack = "BackPack03";
            headgear = "h5";
            uniform[] = {"Soldier06", "Soldier07", "Soldier01"};
        };

        //Squad Leader
        class Soldier_SL_F: Soldier_F {
            backpack = "TFAR_rt1523g_big_rhs";
            headgear = "h6";
            addItemsToBackpack[] = {
                LIST_2("SmokeShellBlue"),
                LIST_2("SmokeShellGreen"),
                LIST_2("SmokeShellOrange"),
                LIST_2("SmokeShellPurple"),
                LIST_2("SmokeShellRed"),
                LIST_2("SmokeShell")
            };
        };

        //Team Leader
        class Soldier_TL_F: Soldier_F {
            primaryWeapon[] = {"arifle_AK12_GL_F", "arifle_AK12_GL_arid_F", "arifle_AK12_GL_lush_F"};
            headgear[] = {"H1", "h3"};
            addItemsToVest[] = {
                LIST_2("HandGrenade"),
                LIST_2("SmokeShell"),
                LIST_2("rhsusf_mag_15Rnd_9x19_JHP"),
                LIST_8("rhs_30Rnd_545x39_7N6_AK"),
                LIST_2("1Rnd_SmokeRed_Grenade_shell"),
                LIST_2("1Rnd_Smoke_Grenade_shell"),
                LIST_2("1Rnd_SmokeBlue_Grenade_shell"),
                LIST_2("1Rnd_HE_Grenade_shell")
            };
        };
    };
};
