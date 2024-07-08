import { useEffect, useState } from 'react'
import SideNav from '../components/SideNav'
import TopNav from '../components/TopNav'
import { BACKEND_URL } from '../constants'
import { ToastContainer, toast } from 'react-toastify';
import "../styles/Users.scss"
import { Plus } from 'lucide-react';
import Footer from '../components/Footer';
import NewUserModal from '../components/NewUserModal';
import ChangePswdModal from '../components/ChangePswdModal';

type user = {
    uname:string,
    user_id:string,
    role:string
}

const empty:user = {uname: "", user_id:"", role:"worker"}

function Users() {
    const [users, setUsers] = useState<user[]>([])
    const [filteredUsers, setFilteredUsers] = useState<user[]>([]);
    const [searchInput, setSearchInput] = useState<string>('');
    const [isModalOpen, setIsModalOpen] = useState<boolean>(false);
    const [currUser, setCurrUser] = useState<user>(empty)
    const [isPswdModalOpen, setIsPswdModalOpen] = useState<boolean>(false);

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

    const openPswdModal = (user:user) => {
        setCurrUser(user)
        setIsPswdModalOpen(true);
    };

    const closePswdModal = () => {
        setIsPswdModalOpen(false);
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
                                                <div onClick={() => openPswdModal(item)} className='btn-opt'>Change Password</div>
                                            </td>
                                        </tr>
                                    )
                                })
                            }
                        </tbody>
                    </table>
                </div>
            </div>
            <ChangePswdModal isOpen={isPswdModalOpen} onRequestClose={closePswdModal} user={currUser}/>
            <NewUserModal isOpen={isModalOpen} onRequestClose={closeModal}/>
            <ToastContainer/>
            <Footer />
        </div>
    )
}

export default Users