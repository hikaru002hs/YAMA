rule sliver_binary_native {

    meta:
        author = "Kev Breen @kevthehermit"
        description = "Detects unmodified Sliver implant generated for Windows, Linux or MacOS"

    strings: 
        $sliverpb = "sliverpb"
        $bishop_git = "github.com/bishopfox/"
        $encryption = "chacha20poly1305"


    condition:
        // This detects Go Headers for PE, ELF, Macho
        (
			(uint16(0) == 0x5a4d) or 
			(uint32(0)==0x464c457f) or 
			(uint32(0) == 0xfeedfacf) or 
			(uint32(0) == 0xcffaedfe) or 
			(uint32(0) == 0xfeedface) or 
			(uint32(0) == 0xcefaedfe) 
		)
        // String matches
        and $sliverpb
        and $bishop_git
        and $encryption
}

rule sliver_memory {

    meta:
        author = "Kev Breen @kevthehermit"
        description = "Detects Sliver running in memory"

    strings: 
        $str1 = "sliverpb"


    condition:
        all of them
}

rule Multi_Trojan_Sliver_42298c4a {
    meta:
        author = "Elastic Security"
        id = "42298c4a-fcea-4c5a-b213-32db00e4eb5a"
        fingerprint = "0734b090ea10abedef4d9ed48d45c834dd5cf8e424886a5be98e484f69c5e12a"
        creation_date = "2021-10-20"
        last_modified = "2022-01-14"
        threat_name = "Multi.Trojan.Sliver"
        reference_sample = "3b45aae401ac64c055982b5f3782a3c4c892bdb9f9a5531657d50c27497c8007"
        severity = 100
        arch_context = "x86"
        scan_context = "file, memory"
        license = "Elastic License v2"
        os = "multi"
    strings:
        $a1 = ").RequestResend"
        $a2 = ").GetPrivInfo"
        $a3 = ").GetReconnectIntervalSeconds"
        $a4 = ").GetPivotID"
        $a5 = "name=PrivInfo"
        $a6 = "name=ReconnectIntervalSeconds"
        $a7 = "name=PivotID"
    condition:
        2 of them
}
rule Multi_Trojan_Sliver_3bde542d {
    meta:
        author = "Elastic Security"
        id = "3bde542d-df52-4f05-84ff-de67e90592a9"
        fingerprint = "e52e39644274e3077769da4d04488963c85a0b691dc9973ad12d51eb34ba388b"
        creation_date = "2022-08-31"
        last_modified = "2022-09-29"
        threat_name = "Multi.Trojan.Sliver"
        reference_sample = "05461e1c2a2e581a7c30e14d04bd3d09670e281f9f7c60f4169e9614d22ce1b3"
        severity = 100
        arch_context = "x86"
        scan_context = "file, memory"
        license = "Elastic License v2"
        os = "multi"
    strings:
        $a1 = "B/Z-github.com/bishopfox/sliver/protobuf/sliverpbb" ascii fullword
        $b1 = "InvokeSpawnDllReq" ascii fullword
        $b2 = "NetstatReq" ascii fullword
        $b3 = "HTTPSessionInit" ascii fullword
        $b4 = "ScreenshotReq" ascii fullword
        $b5 = "RegistryReadReq" ascii fullword
    condition:
        1 of ($a*) or all of ($b*)
}

rule Multi_Trojan_Sliver_3d6b7cd3 {
    meta:
        author = "Elastic Security"
        id = "3d6b7cd3-f702-470c-819c-8750ec040083"
        fingerprint = "46d5388bd1fe767a4852c9e35420985d5011368dac6545fd57fbb256de9a94e9"
        creation_date = "2022-12-01"
        last_modified = "2023-09-20"
        threat_name = "Multi.Trojan.Sliver"
        reference_sample = "9846124cfd124eed466465d187eeacb4d405c558dd84ba8e575d8a7b3290403e"
        severity = 100
        arch_context = "x86"
        scan_context = "file, memory"
        license = "Elastic License v2"
        os = "multi"
    strings:
        $session_start_x86_1 = { 89 4C 24 ?? 89 44 24 ?? 8D 4C 24 ?? 89 4C 24 ?? C6 44 24 ?? ?? 89 04 24 E8 ?? ?? ?? ?? 8B 44 24 ?? 89 44 24 ?? C7 44 24 ?? ?? ?? ?? ?? }
        $session_start_x86_2 = { FF 05 ?? ?? ?? ?? 8D 05 ?? ?? ?? ?? 89 04 24 C7 44 24 ?? ?? ?? ?? ?? E8 ?? ?? ?? ?? 8B 44 24 ?? 8B 4C 24 ?? 85 C9 74 ?? B8 ?? ?? ?? ?? }
        $session_start_x86_3 = { E8 ?? ?? ?? ?? 8B 44 24 ?? 85 C0 74 ?? FF 05 ?? ?? ?? ?? E8 ?? ?? ?? ?? 8B 04 24 39 05 ?? ?? ?? ?? 7E ?? C6 44 24 ?? ?? 8B 54 24 ?? 8B 02 FF D0 83 C4 ?? }
        $session_start_x64_1 = { 44 0F 11 7C 24 ?? 48 8D 0D ?? ?? ?? ?? 48 89 4C 24 ?? 48 89 44 24 ?? 48 8D 4C 24 ?? 48 89 4C 24 ?? C6 44 24 ?? ?? 0F 1F 00 E8 ?? ?? ?? ?? 48 89 44 24 ?? 48 C7 44 24 ?? ?? ?? ?? ?? EB ?? E8 ?? ?? ?? ?? E8 ?? ?? ?? ?? }
        $session_start_x64_2 = { E8 ?? ?? ?? ?? 48 85 C0 74 ?? 48 FF 05 ?? ?? ?? ?? 48 8D 05 ?? ?? ?? ?? BB ?? ?? ?? ?? E8 ?? ?? ?? ?? 48 85 DB B9 ?? ?? ?? ?? 48 0F 45 C1 48 39 05 ?? ?? ?? ?? 7E ?? C6 44 24 ?? ?? 48 8B 54 24 ?? 48 8B 02 FF D0 }
        $session_start_x64_3 = { 48 89 6C 24 ?? 48 8D 6C 24 ?? 49 C7 C5 ?? ?? ?? ?? 4C 89 6C 24 ?? C6 44 24 ?? ?? 48 8D 05 ?? ?? ?? ?? 31 DB E8 ?? ?? ?? ?? 44 0F 11 7C 24 ?? 48 8D 0D ?? ?? ?? ?? 48 89 4C 24 ?? 48 89 44 24 ?? 48 8D 4C 24 ?? 48 89 4C 24 ?? C6 44 24 ?? ?? 0F 1F 00 }
        $register_x64_1 = { 48 81 EC ?? ?? ?? ?? 48 89 AC 24 ?? ?? ?? ?? 48 8D AC 24 ?? ?? ?? ?? 90 E8 ?? ?? ?? ?? 48 89 44 24 ?? 48 89 5C 24 ?? 48 89 4C 24 ?? 0F 1F 44 00 ?? E8 ?? ?? ?? ?? 48 8B 4C 24 ?? 48 85 C9 48 8B 4C 24 ?? BA ?? ?? ?? ?? 48 0F 45 CA 48 89 4C 24 ?? 48 8B 54 24 ?? BE ?? ?? ?? ?? 48 0F 45 D6 48 89 54 24 ?? }
        $register_x64_2 = { 48 8D 1D ?? ?? ?? ?? 48 89 9C 24 ?? ?? ?? ?? 48 C7 84 24 ?? ?? ?? ?? ?? ?? ?? ?? 48 89 9C 24 ?? ?? ?? ?? 48 C7 84 24 ?? ?? ?? ?? ?? ?? ?? ?? 48 89 9C 24 ?? ?? ?? ?? 48 C7 84 24 ?? ?? ?? ?? ?? ?? ?? ?? 48 8D 84 24 ?? ?? ?? ?? }
        $register_x64_3 = { E8 ?? ?? ?? ?? 48 89 84 24 ?? ?? ?? ?? 48 89 5C 24 ?? 48 89 4C 24 ?? 66 90 E8 ?? ?? ?? ?? 48 8B 4C 24 ?? 48 85 C9 48 8B 8C 24 ?? ?? ?? ?? BA ?? ?? ?? ?? 48 0F 45 CA 48 8B 54 24 ?? BE ?? ?? ?? ?? 48 0F 45 D6 48 85 DB 74 ?? 48 8D BC 24 ?? ?? ?? ?? 48 8D 7F ?? 0F 1F 00 48 89 6C 24 ?? 48 8D 6C 24 ?? }
        $register_x64_4 = { 48 89 84 24 ?? ?? ?? ?? 48 89 9C 24 ?? ?? ?? ?? 48 89 8C 24 ?? ?? ?? ?? E8 ?? ?? ?? ?? 48 8B 8C 24 ?? ?? ?? ?? 48 85 C9 48 8B 8C 24 ?? ?? ?? ?? BA ?? ?? ?? ?? 48 0F 45 CA 48 89 8C 24 ?? ?? ?? ?? 48 8B B4 24 ?? ?? ?? ?? BF ?? ?? ?? ?? 48 0F 45 F7 48 89 B4 24 ?? ?? ?? ?? }
        $register_x64_5 = { 48 89 84 24 ?? ?? ?? ?? 48 89 5C 24 ?? 48 89 4C 24 ?? E8 ?? ?? ?? ?? 48 8B 4C 24 ?? 48 85 C9 48 8B 8C 24 ?? ?? ?? ?? BA ?? ?? ?? ?? 48 0F 45 CA 48 89 8C 24 ?? ?? ?? ?? 48 8B 54 24 ?? BE ?? ?? ?? ?? 48 0F 45 D6 48 89 54 24 ?? }
        $register_x64_6 = { E8 ?? ?? ?? ?? 48 8B 6D ?? 48 8B 94 24 ?? ?? ?? ?? 48 89 94 24 ?? ?? ?? ?? 48 8B 94 24 ?? ?? ?? ?? 48 89 94 24 ?? ?? ?? ?? 48 8B 94 24 ?? ?? ?? ?? 48 89 94 24 ?? ?? ?? ?? 48 8B 54 24 ?? 48 89 94 24 ?? ?? ?? ?? 48 89 84 24 ?? ?? ?? ?? 48 89 9C 24 ?? ?? ?? ?? 48 8D 84 24 ?? ?? ?? ?? }
        $register_x64_7 = { E8 ?? ?? ?? ?? C7 40 ?? ?? ?? ?? ?? 48 8B 4C 24 ?? 48 89 48 ?? 48 8B 4C 24 ?? 48 89 48 ?? 83 3D ?? ?? ?? ?? ?? 75 ?? }
        $register_x64_8 = { 48 8D 7F ?? 0F 1F 00 48 89 6C 24 ?? 48 8D 6C 24 ?? E8 ?? ?? ?? ?? 48 8B 6D ?? 4C 8D 15 ?? ?? ?? ?? 4C 89 94 24 ?? ?? ?? ?? 48 C7 84 24 ?? ?? ?? ?? ?? ?? ?? ?? 4C 89 94 24 ?? ?? ?? ?? 48 C7 84 24 ?? ?? ?? ?? ?? ?? ?? ?? 4C 89 94 24 ?? ?? ?? ?? 48 C7 84 24 ?? ?? ?? ?? ?? ?? ?? ?? 48 8D 84 24 ?? ?? ?? ?? }
        $register_x86_1 = { E8 ?? ?? ?? ?? 8B 44 24 ?? 8B 0C 24 8B 54 24 ?? 85 C0 74 ?? 31 C9 31 D2 89 54 24 ?? 89 4C 24 ?? E8 ?? ?? ?? ?? 8B 04 24 8B 4C 24 ?? 85 C9 74 ?? 8D 7C 24 ?? }
        $register_x86_2 = { 8D 0D ?? ?? ?? ?? 89 4C 24 ?? C7 44 24 ?? ?? ?? ?? ?? 89 4C 24 ?? C7 44 24 ?? ?? ?? ?? ?? 89 4C 24 ?? C7 44 24 ?? ?? ?? ?? ?? 8D 44 24 ?? }
        $register_x86_3 = { C7 40 ?? ?? ?? ?? ?? 8D 0D ?? ?? ?? ?? 89 48 ?? 8B 4C 24 ?? 89 48 ?? 8B 4C 24 ?? 89 48 ?? 8B 0D ?? ?? ?? ?? 85 C9 75 ?? }
        $register_x86_4 = { E8 ?? ?? ?? ?? 8B 44 24 ?? 8B 0C 24 8B 54 24 ?? 85 C0 74 ?? 31 C9 31 D2 89 54 24 ?? 89 ?? 24 }
        $register_x86_5 = { 8B 04 24 89 84 24 ?? ?? ?? ?? 8B 4C 24 ?? 89 4C 24 ?? E8 ?? ?? ?? ?? 8B 04 24 8B 4C 24 ?? 8B 54 24 ?? 85 D2 74 ?? 31 C0 31 C9 89 4C 24 ?? 89 84 24 ?? ?? ?? ?? 8D 15 ?? ?? ?? ?? 89 14 24 E8 ?? ?? ?? ?? }
    condition:
        1 of ($session_start_*) and 1 of ($register_*)
}
rule Windows_Trojan_Sliver_46525b49 {
    meta:
        author = "Elastic Security"
        id = "46525b49-f426-4ecb-9bd6-36752f0461e9"
        fingerprint = "104382f222b754b3de423803ac7be1d6fbdd9cbd11c855774d1ecb1ee73cb6c0"
        creation_date = "2023-05-09"
        last_modified = "2023-06-13"
        threat_name = "Windows.Trojan.Sliver"
        reference_sample = "ecce5071c28940a1098aca3124b3f82e0630c4453f4f32e1b91576aac357ac9c"
        severity = 100
        arch_context = "x86"
        scan_context = "file, memory"
        license = "Elastic License v2"
        os = "windows"
    strings:
        $a1 = { B6 54 0C 48 0F B6 74 0C 38 31 D6 40 88 74 0C 38 48 FF C1 48 83 }
        $a2 = { 42 18 4C 8B 4A 20 48 8B 52 28 48 39 D9 73 51 48 89 94 24 C0 00 }
    condition:
        all of them
}

rule Windows_Trojan_Sliver_c9cae357 {
    meta:
        author = "Elastic Security"
        id = "c9cae357-9270-4871-8fad-d9c43dcab644"
        fingerprint = "5366540c4a4f4a502b550f5397f3b53e3bc909cbc0cb82a2091cabb19bc135aa"
        creation_date = "2023-05-10"
        last_modified = "2023-06-13"
        threat_name = "Windows.Trojan.Sliver"
        reference_sample = "27210d8d6e16c492c2ee61a59d39c461312f5563221ad4a0917d4e93b699418e"
        severity = 100
        arch_context = "x86"
        scan_context = "file, memory"
        license = "Elastic License v2"
        os = "windows"
    strings:
        $a1 = { B1 F9 3C 0A 68 0F B4 B5 B5 B5 21 B2 38 23 29 D8 6F 83 EC 68 51 8E }
    condition:
        all of them
}

rule Windows_Trojan_Sliver_1dd6d9c2 {
    meta:
        author = "Elastic Security"
        id = "1dd6d9c2-026e-4140-b804-b56e07c72ac2"
        fingerprint = "fb676adf8b9d10d1e151bfb2a6a7e132cff4e55c20f454201a4ece492902fc35"
        creation_date = "2023-05-10"
        last_modified = "2023-06-13"
        threat_name = "Windows.Trojan.Sliver"
        reference_sample = "dc508a3e9ea093200acfc1ceebebb2b56686f4764fd8c94ab8c58eec7ee85c8b"
        severity = 100
        arch_context = "x86"
        scan_context = "file, memory"
        license = "Elastic License v2"
        os = "windows"
    strings:
        $a1 = { B7 11 49 89 DB C1 EB 10 41 01 DA 66 45 89 11 4C 89 DB EB B6 4D 8D }
        $a2 = { 36 2E 33 20 62 75 69 6C 48 39 }
    condition:
        all of them
}
