module MyModule::PatientRecords {

    use aptos_framework::signer;
    use std::string;

   
    struct MedicalRecord has store, key {
        data: string::String,        // Simplified medical info
        authorized_doctor: address,  // Address of the doctor
    }

    
    public fun create_record(patient: &signer, data: string::String, doctor: address) {
        let record = MedicalRecord {
            data,
            authorized_doctor: doctor,
        };
        move_to(patient, record);
    }

    
    public fun grant_access(doctor: &signer, patient_addr: address): string::String acquires MedicalRecord {
        let record = borrow_global<MedicalRecord>(patient_addr);
        assert!(signer::address_of(doctor) == record.authorized_doctor, 1);
        record.data
    }
}