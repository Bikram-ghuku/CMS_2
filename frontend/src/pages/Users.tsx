import { useEffect, useState } from 'react'
import SideNav from '../components/SideNav'
import TopNav from '../components/TopNav'
import { BACKEND_URL } from '../constants'
import { ToastContainer, toast } from 'react-toastify';
import { Link } from 'react-router-dom';
import "../styles/Users.scss"
import { Plus } from 'lucide-react';
import Modal from 'react-modal'

type user = {
    uname:string,
    user_id:string,
    role:string
}

const roleOptions = [['admin', 'Administrator'], ['worker', 'Worker'], ['inven_manage', 'Inventory Manager']];


function Users() {
    const [users, setUsers] = useState<user[]>([])
    const [filteredUsers, setFilteredUsers] = useState<user[]>([]);
    const [searchInput, setSearchInput] = useState<string>('');
    const [isModalOpen, setIsModalOpen] = useState<boolean>(false);
    const [newUsername, setNewUsername] = useState<string>('');
    const [newPassword, setNewPassword] = useState<string>('');
    const [newRole, setNewRole] = useState<string>(roleOptions[0][0]);

    useEffect(() => {
        fetch(BACKEND_URL+'/user/all', {
            method:"GET",
            credentials:'include'
        }).then((data) => {
            if(data.ok){
                data.json().then((jsondata:user[]) => {
                    setUsers(jsondata)
                    setFilteredUsers(jsondata)
                })
            }else{
                toast.error("Loading Error", {
                    position: "bottom-center"
              })
            }
        })
    }, [])

    const handleSearchInputChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        const inputValue = event.target.value;
        setSearchInput(inputValue);
        filterUsers(inputValue);
    };

    const filterUsers = (searchText: string) => {
        const filtered = users.filter((user) =>
            user.uname.toLowerCase().includes(searchText.toLowerCase())
        );
        setFilteredUsers(filtered);
    };

    const openModal = () => {
        setIsModalOpen(true);
    };

    const closeModal = () => {
        setIsModalOpen(false);
    };

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
            setIsModalOpen(false)
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
        <div>
            <SideNav />
            <TopNav />
            <div className="user-main">
                <div className="user-title">Registered Users</div>
                <div className="user-actions">
                    <div className="user-search">
                        <input
                            placeholder='Enter Name to search'
                            value={searchInput}
                            onChange={handleSearchInputChange}
                        />
                    </div>
                    <div className="user-add">
                        <button className='user-add-btn' onClick={() => openModal()}>
                            <Plus /> New user
                        </button>
                    </div>
                </div>
                <div className="user-table">
                    <table>
                        <thead>
                            <tr>
                                <th>Username</th>
                                <th>Role</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            {
                                filteredUsers.map((item, idx) => {

                                    return (
                                        <tr key={idx}>
                                            <td>{item.uname}</td>
                                            <td>{item.role}</td>
                                            <td>
                                                <Link to={"./forgot_pswd/"+item.user_id}>Forgot Password</Link>
                                            </td>
                                        </tr>
                                    )
                                })
                            }
                        </tbody>
                    </table>
                </div>
            </div>
            <Modal
                isOpen={isModalOpen}
                onRequestClose={closeModal}
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
            <ToastContainer/>
        </div>
    )
}

export default Users