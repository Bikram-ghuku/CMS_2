import React, { useState } from 'react'
import Modal from 'react-modal'
import { BACKEND_URL } from '../constants'
import { toast } from 'react-toastify';


interface AddUserModalProps {
    isOpen: boolean;
    onRequestClose: () => void;
}

const roleOptions = [['admin', 'Administrator'], ['worker', 'Worker'], ['inven_manage', 'Inventory Manager']];

const NewUserModal: React.FC<AddUserModalProps> = ({
    isOpen,
    onRequestClose
}) => {

    const [newUsername, setNewUsername] = useState<string>('');
    const [newPassword, setNewPassword] = useState<string>('');
    const [newRole, setNewRole] = useState<string>(roleOptions[0][0]);

    const handleUsernameChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        setNewUsername(event.target.value);
    };

    const handlePasswordChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        setNewPassword(event.target.value);
    };

    const handleRoleChange = (event: React.ChangeEvent<HTMLSelectElement>) => {
        setNewRole(event.target.value);
    };

    const handleRegister = () => {
        fetch(BACKEND_URL+"/user/rolereg", {
            method:"POST",
            credentials:"include",
            body:JSON.stringify({uname: newUsername, pswd: newPassword, role: newRole})
        }).then((data) => {
            onRequestClose()
            setNewPassword('')
            setNewUsername('')
            if(data.ok){
                toast.success("New User added successfully", {
                    position: "bottom-center"
                })
            }else{
                toast.error("Error adding new user", {
                    position: "bottom-center"
                })
            }
        })
    };
    return (
        <Modal
            isOpen={isOpen}
            onRequestClose={onRequestClose}
            contentLabel="New User Modal"
            className="modal"
            overlayClassName="overlay"
            >
                <h2>New User Registration</h2>
                <form>
                    <label>Username:</label>
                    <input
                        type="text"
                        value={newUsername}
                        onChange={handleUsernameChange}
                    />
                    <label>Password:</label>
                    <input
                        type="password"
                        value={newPassword}
                        onChange={handlePasswordChange}
                    />
                    <label>Role:</label>
                    <select value={newRole} onChange={handleRoleChange}>
                        {roleOptions.map((role, index) => (
                            <option key={index} value={role[0]}>{role[1]}</option>
                        ))}
                    </select>
                    <button type="button" onClick={handleRegister}>Register</button>
                </form>
            </Modal>
    )
}

export default NewUserModal