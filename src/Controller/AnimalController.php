<?php

namespace App\Controller;

use App\Entity\User;
use App\Form\RegistrationType;
use App\Repository\DierRepository;
use Doctrine\ORM\EntityManager;
use Doctrine\ORM\EntityManagerInterface;
use http\Env\Request;
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
    #[Route('/member', name: 'member')]
    public function member(DierRepository $dierRepository): Response
    {
        $user = $this->getUser();
        $beschrijving = $dierRepository->findAll();
        return $this->render('animal/home.html.twig', [
            'user' =>$user,
            'beschrijving' =>$beschrijving
        ]);

    }

    #[Route('/register', name: 'register')]
    public function register(EntityManagerInterface $em , Request $request): Response
    {
        $register = new User();
//        $registration = $em->getRepository(User::class);
        $form = $this->renderForm(RegistrationType::class , $register);
        $form->handleRequest($request);
        if($form->isInvalid() && $form->isSuccessful()){
            $data = $form->getData();
            $em->persist($data);
            $em->flush();
            return $this->addFlash('succes' , 'registratie toegevoegt');
            return $this->redirectToRoute('index');
        }
        return $this->renderForm('animal/registratie.html.twig', [
            'form' =>$form
        ]);
    }

    #[Route('/redirect', name: 'redirect')]
    public function redirectAction(Security $security): RedirectResponse
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
