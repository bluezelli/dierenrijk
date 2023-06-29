<?php

namespace App\Controller;

use Doctrine\ORM\EntityManager;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Core\Security;
use Symfony\Component\Security\Http\Authentication\AuthenticationUtils;
use Symfony\Component\HttpFoundation\RedirectResponse;

class AnimalController extends AbstractController
{
    #[Route('/index', name: 'index')]
    public function index(): Response
    {
        return $this->render('animal/index.html.twig', [
            'controller_name' => 'AnimalController',
        ]);
    }

    #[Route('/login', name: 'login')]
    public function login(AuthenticationUtils $authenticationUtils): Response
    {
        $error = $authenticationUtils->getLastAuthenticationError();
        $lastusername = $authenticationUtils->getLastUsername();
        return $this->render('animal/login.html.twig', [
            'lastusername' => $lastusername,
            'error' => $error
        ]);
    }

    #[Route('/register', name: 'register')]
    public function register(EntityManagerInterface $em , ): Response
    {
        return new Response('register');
    }

    #[Route('/redirect', name: 'redirect')]
    public function redirectAction(Security $security)
    {
        if($security->isGranted('ROLE_ADMIN')){
            return $this->redirectToRoute('admin');

        }
        if($security->isGranted('ROLE_MEMBER')) {
            return $this->redirectToRoute('member');
    }
        return $this->redirectToRoute('index');

    }

}
