<?php

namespace App\Controller;

use App\Entity\User;
use App\Repository\UserRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class AdminController extends AbstractController
{
    #[Route('/admin', name: 'app_admin')]
    public function index(UserRepository $userRepository): Response
    {
        $user = $this->getUser();
        $description = $userRepository->findAll();

        return $this->render('admin/index.html.twig', [
            'user' =>$user,
            'description' =>$description
        ]);
    }
}
