import React, { useEffect, useState } from 'react'
import Modal from 'react-modal'
import { BACKEND_URL } from '../constants'
import { toast } from 'react-toastify';


type user = {
    uname:string,
    user_id:string,
}

interface AddUserModalProps {
    isOpen: boolean;
    onRequestClose: () => void;
    user: user;
}


const ChangePswdModal: React.FC<AddUserModalProps> = ({
    user,
    isOpen,
    onRequestClose
}) => {

    const [newUsername, setNewUsername] = useState<string>('');
    const [newPassword, setNewPassword] = useState<string>('');

    useEffect(() => {
        setNewUsername(user.uname)
    }, [user])

    const handleUsernameChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        setNewUsername(event.target.value);
    };

    const handlePasswordChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        setNewPassword(event.target.value);
    };


    const handleRegister = () => {
        fetch(BACKEND_URL+"/user/chngpswd", {
            method:"POST",
            credentials:"include",
            body:JSON.stringify({uname: newUsername, user_pswd: newPassword, user_id: user.user_id})
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
            contentLabel="Change Password Modal"
            className="modal"
            overlayClassName="overlay"
            >
                <h2>Change Password</h2>
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
                    <button type="button" onClick={handleRegister}>Update</button>
                </form>
            </Modal>
    )
}

export default ChangePswdModal